Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE9C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C47F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCKFrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:47:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:28140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgCKFrR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 22:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="389160378"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2020 22:47:12 -0700
Subject: Re: [PATCH v1 08/14] perf util: Add new block info functions for top
 N hot blocks comparison
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-9-yao.jin@linux.intel.com>
 <20200310151728.GI15931@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9c3a3a21-c94b-a28b-1ce4-120113c643d0@linux.intel.com>
Date:   Wed, 11 Mar 2020 13:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310151728.GI15931@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2020 11:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 10, 2020 at 03:02:39PM +0800, Jin Yao escreveu:
>> It's also useful to figure out the top N hottest blocks from old perf
>> data file and figure out the top N hottest blocks from new perf data file,
>> and then compare them for the cycles diff. It can let us easily know
>> how many cycles are moved from one block to another block.
>>
>> This patch adds new helper functions and data structures for the block
>> comparison.
>>
>> And it also updates the existing perf-diff to be compatible with
>> the new interface.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-diff.c    |  45 +-----
>>   tools/perf/util/block-info.c | 305 ++++++++++++++++++++++++++++++++++-
>>   tools/perf/util/block-info.h |  32 +++-
>>   tools/perf/util/srclist.h    |   9 ++
>>   4 files changed, 345 insertions(+), 46 deletions(-)
>>
>> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
>> index 9c801b9bc5bb..dcbc9bba4e61 100644
>> --- a/tools/perf/builtin-diff.c
>> +++ b/tools/perf/builtin-diff.c
>> @@ -598,27 +598,6 @@ static void init_block_hist(struct block_hist *bh)
>>   	bh->valid = true;
>>   }
>>   
>> -static struct hist_entry *get_block_pair(struct hist_entry *he,
>> -					 struct hists *hists_pair)
>> -{
>> -	struct rb_root_cached *root = hists_pair->entries_in;
>> -	struct rb_node *next = rb_first_cached(root);
>> -	int64_t cmp;
>> -
>> -	while (next != NULL) {
>> -		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
>> -						      rb_node_in);
>> -
>> -		next = rb_next(&he_pair->rb_node_in);
>> -
>> -		cmp = __block_info__cmp(he_pair, he);
>> -		if (!cmp)
>> -			return he_pair;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>>   static void init_spark_values(unsigned long *svals, int num)
>>   {
>>   	for (int i = 0; i < num; i++)
>> @@ -665,26 +644,6 @@ static void compute_cycles_diff(struct hist_entry *he,
>>   	}
>>   }
>>   
>> -static void block_hists_match(struct hists *hists_base,
>> -			      struct hists *hists_pair)
>> -{
>> -	struct rb_root_cached *root = hists_base->entries_in;
>> -	struct rb_node *next = rb_first_cached(root);
>> -
>> -	while (next != NULL) {
>> -		struct hist_entry *he = rb_entry(next, struct hist_entry,
>> -						 rb_node_in);
>> -		struct hist_entry *pair = get_block_pair(he, hists_pair);
>> -
>> -		next = rb_next(&he->rb_node_in);
>> -
>> -		if (pair) {
>> -			hist_entry__add_pair(pair, he);
>> -			compute_cycles_diff(he, pair);
>> -		}
>> -	}
>> -}
>> -
>>   static void hists__precompute(struct hists *hists)
>>   {
>>   	struct rb_root_cached *root;
>> @@ -737,7 +696,9 @@ static void hists__precompute(struct hists *hists)
>>   
>>   				if (bh->valid && pair_bh->valid) {
>>   					block_hists_match(&bh->block_hists,
>> -							  &pair_bh->block_hists);
>> +							  &pair_bh->block_hists,
>> +							  NULL,
>> +							  compute_cycles_diff);
>>   					hists__output_resort(&pair_bh->block_hists,
>>   							     NULL);
>>   				}
>> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
>> index 423ec69bda6c..247c87b8df56 100644
>> --- a/tools/perf/util/block-info.c
>> +++ b/tools/perf/util/block-info.c
>> @@ -12,6 +12,7 @@
>>   #include "evlist.h"
>>   #include "hist.h"
>>   #include "ui/browsers/hists.h"
>> +#include "debug.h"
>>   
>>   static struct block_header_column {
>>   	const char *name;
>> @@ -50,10 +51,24 @@ struct block_info *block_info__get(struct block_info *bi)
>>   	return bi;
>>   }
>>   
>> +static void free_block_line(struct block_line **bl)
> 
> static void block_line__zdelete(struct block_line **bl)
> 

Sorry about that. I should use the struct name as the perfix. I will 
keep in mind.

>> +{
>> +	if ((*bl)->start_file)
>> +		free((*bl)->start_file);
>> +
>> +	if ((*bl)->end_file)
>> +		free((*bl)->end_file);
>> +
>> +	zfree(bl);
>> +}
>> +
>>   void block_info__put(struct block_info *bi)
> 
> Correct naming, cool.
> 

:)

Thanks
Jin Yao

>>   {
>> -	if (bi && refcount_dec_and_test(&bi->refcnt))
>> +	if (bi && refcount_dec_and_test(&bi->refcnt)) {
>> +		if (bi->line)
>> +			free_block_line(&bi->line);
>>   		free(bi);
>> +	}
>>   }
>>   
>>   struct block_info *block_info__new(void)
>> @@ -65,7 +80,8 @@ struct block_info *block_info__new(void)
>>   	return bi;
>>   }
>>   
>> -int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
>> +int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
>> +			  struct srclist *src_list __maybe_unused)
>>   {
>>   	struct block_info *bi_l = left->block_info;
>>   	struct block_info *bi_r = right->block_info;
>> @@ -93,7 +109,7 @@ int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right)
>>   int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>>   			struct hist_entry *left, struct hist_entry *right)
>>   {
>> -	return __block_info__cmp(left, right);
>> +	return __block_info__cmp(left, right, NULL);
>>   }
>>   
>>   static void init_block_info(struct block_info *bi, struct symbol *sym,
>> @@ -446,8 +462,10 @@ struct block_report *block_info__create_report(struct evlist *evlist,
>>   	evlist__for_each_entry(evlist, pos) {
>>   		struct hists *hists = evsel__hists(pos);
>>   
>> +		hists__output_resort(hists, NULL);
>>   		process_block_report(hists, &block_reports[i], total_cycles,
>>   				     block_hpps, nr_hpps);
>> +		block_reports[i].evsel_idx = pos->idx;
>>   		i++;
>>   	}
>>   
>> @@ -496,3 +514,284 @@ float block_info__total_cycles_percent(struct hist_entry *he)
>>   
>>   	return 0.0;
>>   }
>> +
>> +struct block_report *block_info__get_report(struct block_report *reps,
>> +					    int nr_reps, int evsel_idx)
>> +{
>> +	for (int i = 0; i < nr_reps; i++) {
>> +		if (reps[i].evsel_idx == evsel_idx)
>> +			return &reps[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static char *move_to_relpath(char *path, const char *dir)
>> +{
>> +	const char *d = dir, *end = dir + strlen(dir);
>> +	char *s;
>> +
>> +	/* skip '.' and '/' */
>> +	while ((d != end) && ((*d == '.') || (*d == '/')))
>> +		d++;
>> +
>> +	if (d == end)
>> +		return NULL;
>> +
>> +	s = strstr(path, d);
>> +	if (!s)
>> +		return NULL;
>> +
>> +	s += strlen(d);
>> +
>> +	while (*s == '/' && *s != 0)
>> +		s++;
>> +
>> +	if (*s == 0)
>> +		return NULL;
>> +
>> +	return s;
>> +}
>> +
>> +static int block_addr2line(struct hist_entry *he, const char *dir)
>> +{
>> +	struct block_info *bi = he->block_info;
>> +	struct block_line *bl;
>> +
>> +	if (!he->ms.map || !he->ms.map->dso)
>> +		return -1;
>> +
>> +	bl = zalloc(sizeof(*bl));
>> +	if (!bl)
>> +		return -1;
>> +
>> +	symbol_conf.disable_add2line_warn = true;
>> +	bl->start_file = get_srcline_split(he->ms.map->dso,
>> +					   map__rip_2objdump(he->ms.map,
>> +							     bi->sym->start + bi->start),
>> +					   &bl->start_nr);
>> +	if (!bl->start_file)
>> +		goto err;
>> +
>> +	if (dir)
>> +		bl->start_rel = move_to_relpath(bl->start_file, dir);
>> +
>> +	bl->end_file = get_srcline_split(he->ms.map->dso,
>> +					 map__rip_2objdump(he->ms.map,
>> +							   bi->sym->start + bi->end),
>> +					 &bl->end_nr);
>> +	if (!bl->end_file)
>> +		goto err;
>> +
>> +	if (dir)
>> +		bl->end_rel = move_to_relpath(bl->end_file, dir);
>> +
>> +	bi->line = bl;
>> +	return 0;
>> +
>> +err:
>> +	free_block_line(&bl);
>> +	return -1;
>> +}
>> +
>> +int block_hists_addr2line(struct hists *hists, const char *dir)
>> +{
>> +	struct rb_root_cached *root = hists->entries_in;
>> +	struct rb_node *next = rb_first_cached(root);
>> +
>> +	while (next != NULL) {
>> +		struct hist_entry *he = rb_entry(next, struct hist_entry,
>> +						 rb_node_in);
>> +
>> +		if (!he)
>> +			break;
>> +
>> +		block_addr2line(he, dir);
>> +		next = rb_next(&he->rb_node_in);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +bool block_same_srcfiles(struct block_line *bl_a, struct block_line *bl_b)
>> +{
>> +	if (!bl_a->start_file || !bl_a->end_file ||
>> +	    !bl_b->start_file || !bl_b->end_file) {
>> +		return false;
>> +	}
>> +
>> +	if (!strcmp(bl_a->start_file, bl_b->start_file) &&
>> +	    !strcmp(bl_a->end_file, bl_b->end_file) &&
>> +	    !strcmp(bl_a->start_file, bl_a->end_file)) {
>> +		return true;
>> +	}
>> +
>> +	if (!bl_a->start_rel || !bl_a->end_rel ||
>> +	    !bl_b->start_rel || !bl_b->end_rel) {
>> +		return false;
>> +	}
>> +
>> +	if (!strcmp(bl_a->start_rel, bl_b->start_rel) &&
>> +	    !strcmp(bl_a->end_rel, bl_b->end_rel) &&
>> +	    !strcmp(bl_a->start_rel, bl_a->end_rel)) {
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +void block_line_dump(struct block_info *bi, const char *str)
>> +{
>> +	if (bi && bi->line) {
>> +		pr_debug("%s: %s:%d -> %s:%d\n",
>> +			 str,
>> +			 bi->line->start_file,
>> +			 bi->line->start_nr,
>> +			 bi->line->end_file,
>> +			 bi->line->end_nr);
>> +	}
>> +}
>> +
>> +static bool block_line_matched(struct src_node *node,
>> +			       int start_nr_a, int end_nr_a,
>> +			       int start_nr_b, int end_nr_b,
>> +			       bool *changed)
>> +{
>> +	int i, j, start_a, end_a, start_b, changed_nr = 0;
>> +	struct line_pair *lp;
>> +
>> +	*changed = false;
>> +
>> +	if (abs(end_nr_a - start_nr_a) !=
>> +	    abs(end_nr_b - start_nr_b)) {
>> +		return false;
>> +	}
>> +
>> +	i = start_a = (start_nr_a < end_nr_a) ? start_nr_a : end_nr_a;
>> +	end_a = (end_nr_a > start_nr_a) ? end_nr_a : start_nr_a;
>> +
>> +	j = start_b = (start_nr_b < end_nr_b) ? start_nr_b : end_nr_b;
>> +
>> +	while (i <= end_a) {
>> +		lp = srclist__line_pair(node, i);
>> +		if (!lp)
>> +			return false;
>> +
>> +		if (lp->b_nr != j)
>> +			changed_nr++;
>> +
>> +		i++; j++;
>> +	}
>> +
>> +	if ((i == end_a + 1) && (changed_nr == 0))
>> +		return true;
>> +
>> +	/*
>> +	 * At least one line is unchanged in this block,
>> +	 * we think this block is changed (not a new block).
>> +	 */
>> +	if (changed_nr < end_a - start_a + 1)
>> +		*changed = true;
>> +
>> +	return false;
>> +}
>> +
>> +bool block_srclist_matched(struct srclist *slist, char *rel_path,
>> +			   int start_nr_a, int end_nr_a,
>> +			   int start_nr_b, int end_nr_b,
>> +			   bool *changed)
>> +{
>> +	struct src_node *node;
>> +	bool ret;
>> +
>> +	*changed = false;
>> +
>> +	node = srclist__find(slist, rel_path, true);
>> +	if (!node)
>> +		return false;
>> +
>> +	ret = block_line_matched(node, start_nr_a, end_nr_a,
>> +				 start_nr_b, end_nr_b, changed);
>> +
>> +	if (ret) {
>> +		pr_debug("block MATCHED (a vs. b)\t\t%s: (%d-%d) vs. (%d-%d)\n",
>> +			 node->info.rel_path,
>> +			 start_nr_a, end_nr_a,
>> +			 start_nr_b, end_nr_b);
>> +	} else if (*changed) {
>> +		pr_debug("block CHANGED (a vs. b)\t\t%s: (%d-%d) vs. (%d-%d)\n",
>> +			 node->info.rel_path,
>> +			 start_nr_a, end_nr_a,
>> +			 start_nr_b, end_nr_b);
>> +	} else {
>> +		pr_debug("block UNMATCHED (a vs. b)\t%s: (%d-%d) vs. (%d-%d)\n",
>> +			 node->info.rel_path,
>> +			 start_nr_a, end_nr_a,
>> +			 start_nr_b, end_nr_b);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static struct hist_entry *get_block_pair(struct hist_entry *he,
>> +					 struct hists *hists_pair,
>> +					 struct srclist *src_list)
>> +{
>> +	struct rb_root_cached *root = hists_pair->entries_in;
>> +	struct rb_node *next = rb_first_cached(root);
>> +	int64_t cmp;
>> +
>> +	while (next != NULL) {
>> +		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
>> +						      rb_node_in);
>> +
>> +		next = rb_next(&he_pair->rb_node_in);
>> +
>> +		cmp = __block_info__cmp(he_pair, he, src_list);
>> +		if (!cmp)
>> +			return he_pair;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void block_hists_match(struct hists *hists_base,
>> +		       struct hists *hists_pair,
>> +		       struct srclist *src_list,
>> +		       void (*func)(struct hist_entry *,
>> +				    struct hist_entry *))
>> +{
>> +	struct rb_root_cached *root = hists_base->entries_in;
>> +	struct rb_node *next = rb_first_cached(root);
>> +
>> +	while (next != NULL) {
>> +		struct hist_entry *he = rb_entry(next, struct hist_entry,
>> +						 rb_node_in);
>> +		struct hist_entry *pair = get_block_pair(he, hists_pair,
>> +							 src_list);
>> +
>> +		next = rb_next(&he->rb_node_in);
>> +
>> +		if (pair) {
>> +			hist_entry__add_pair(pair, he);
>> +
>> +			if (func)
>> +				(*func)(he, pair);
>> +		}
>> +	}
>> +}
>> +
>> +int block_info__match_report(struct block_report *rep_base,
>> +			     struct block_report *rep_pair,
>> +			     struct srclist *src_list,
>> +			     void (*func)(struct hist_entry *,
>> +					  struct hist_entry *))
>> +{
>> +	struct block_hist *bh_base = &rep_base->hist;
>> +	struct block_hist *bh_pair = &rep_pair->hist;
>> +
>> +	block_hists_match(&bh_base->block_hists, &bh_pair->block_hists,
>> +			  src_list, func);
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
>> index 42e9dcc4cf0a..458bd998089d 100644
>> --- a/tools/perf/util/block-info.h
>> +++ b/tools/perf/util/block-info.h
>> @@ -20,6 +20,8 @@ struct block_info {
>>   	int			num;
>>   	int			num_aggr;
>>   	refcount_t		refcnt;
>> +	struct block_line	*line;
>> +	bool			srcline_matched;
>>   };
>>   
>>   struct block_fmt {
>> @@ -46,6 +48,7 @@ struct block_report {
>>   	u64			cycles;
>>   	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
>>   	int			nr_fmts;
>> +	int			evsel_idx;
>>   };
>>   
>>   struct block_hist;
>> @@ -62,7 +65,8 @@ static inline void __block_info__zput(struct block_info **bi)
>>   
>>   #define block_info__zput(bi) __block_info__zput(&bi)
>>   
>> -int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right);
>> +int64_t __block_info__cmp(struct hist_entry *left, struct hist_entry *right,
>> +			  struct srclist *src_list __maybe_unused);
>>   
>>   int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>>   			struct hist_entry *left, struct hist_entry *right);
>> @@ -83,4 +87,30 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>>   
>>   float block_info__total_cycles_percent(struct hist_entry *he);
>>   
>> +struct block_report *block_info__get_report(struct block_report *reps,
>> +					    int nr_reps, int evsel_idx);
>> +
>> +int block_hists_addr2line(struct hists *hists, const char *dir);
>> +
>> +void block_line_dump(struct block_info *bi, const char *str);
>> +
>> +bool block_same_srcfiles(struct block_line *bl_a, struct block_line *bl_b);
>> +
>> +bool block_srclist_matched(struct srclist *slist, char *rel_path,
>> +			   int start_nr_a, int end_nr_a,
>> +			   int start_nr_b, int end_nr_b,
>> +			   bool *changed);
>> +
>> +void block_hists_match(struct hists *hists_base,
>> +		       struct hists *hists_pair,
>> +		       struct srclist *src_list,
>> +		       void (*func)(struct hist_entry *,
>> +				    struct hist_entry *));
>> +
>> +int block_info__match_report(struct block_report *rep_base,
>> +			     struct block_report *rep_pair,
>> +			     struct srclist *src_list,
>> +			     void (*func)(struct hist_entry *,
>> +					  struct hist_entry *));
>> +
>>   #endif /* __PERF_BLOCK_H */
>> diff --git a/tools/perf/util/srclist.h b/tools/perf/util/srclist.h
>> index f25b0de91a13..46866d5c51d7 100644
>> --- a/tools/perf/util/srclist.h
>> +++ b/tools/perf/util/srclist.h
>> @@ -33,6 +33,15 @@ struct srclist {
>>   	const char *after_dir;
>>   };
>>   
>> +struct block_line {
>> +	char *start_file;
>> +	char *end_file;
>> +	char *start_rel;
>> +	char *end_rel;
>> +	unsigned int start_nr;
>> +	unsigned int end_nr;
>> +};
>> +
>>   struct srclist *srclist__new(const char *before_dir, const char *after_dir);
>>   void srclist__delete(struct srclist *slist);
>>   
>> -- 
>> 2.17.1
>>
> 
