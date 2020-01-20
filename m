Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF84C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF12073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha68Fivp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATKIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:08:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgATKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579514914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3PQUFu4L/LHSSezymT7MZ4Yeqln5RstKhroASGQQZo=;
        b=ha68FivpIVsJswpcdjdx/S1D+eeJfzt4REUmfcgLdX7/4Dxm5TZugsvSaMnTanYpSjSFis
        KNyp+w5auGg1NO1CeIVmni9sKsYF4CXHeCy+gQ4Xu20ZWGihLc7TKLyYWiTmsyQ+1CCvnn
        hho4ZSt6qCkTKnBN3m1uilphNYduPRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-kka-0EdgNBK1tnupSNcKIw-1; Mon, 20 Jan 2020 05:08:31 -0500
X-MC-Unique: kka-0EdgNBK1tnupSNcKIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAADF107ACC7;
        Mon, 20 Jan 2020 10:08:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C5A10013A7;
        Mon, 20 Jan 2020 10:08:28 +0000 (UTC)
Date:   Mon, 20 Jan 2020 11:08:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf annotate: Nuke privsize
Message-ID: <20200120100825.GG608405@krava>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
 <20200117092612.30874-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117092612.30874-2-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:56:10PM +0530, Ravi Bangoria wrote:
> We don't use privsize now and it's always 0. Remove privsize
> from code. Also simplify disasm_line allocation and freeing
> code which was bit complex because of privsize.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/builtin-top.c     |  2 +-
>  tools/perf/ui/gtk/annotate.c |  2 +-
>  tools/perf/util/annotate.c   | 92 +++++++++++++-----------------------
>  tools/perf/util/annotate.h   |  3 +-
>  4 files changed, 35 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 795e353de095..26765e41c083 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
>  		return err;
>  	}
>  
> -	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
> +	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
>  	if (err == 0) {
>  		top->sym_filter_entry = he;
>  	} else {
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 22cc240f7371..35f9641bf670 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (ms->map->dso->annotate_warned)
>  		return -1;
>  
> -	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
> +	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
>  	if (err) {
>  		char msg[BUFSIZ];
>  		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f5e77ed237e8..7f9851772462 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1143,7 +1143,6 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
>  }
>  
>  struct annotate_args {
> -	size_t			 privsize;
>  	struct arch		*arch;
>  	struct map_symbol	 ms;
>  	struct evsel	*evsel;
> @@ -1153,83 +1152,55 @@ struct annotate_args {
>  	int			 line_nr;
>  };
>  
> -static void annotation_line__delete(struct annotation_line *al)
> +static void annotation_line__new(struct annotation_line *al,
> +				 struct annotate_args *args,
> +				 int nr)
>  {
> -	void *ptr = (void *) al - al->privsize;
> -
> -	free_srcline(al->path);
> -	zfree(&al->line);
> -	free(ptr);
> +	al->offset = args->offset;
> +	al->line = strdup(args->line);
> +	al->line_nr = args->line_nr;
> +	al->data_nr = nr;
>  }
>  
> -/*
> - * Allocating the annotation line data with following
> - * structure:
> - *
> - *    --------------------------------------
> - *    private space | struct annotation_line
> - *    --------------------------------------
> - *
> - * Size of the private space is stored in 'struct annotation_line'.
> - *
> - */
> -static struct annotation_line *
> -annotation_line__new(struct annotate_args *args, size_t privsize)
> +static size_t disasm_line_size(int nr)
>  {

I agree we can get rid of the 'users' privsize passed from symbol__annotate,
but could you please put it in separate patch, while keeping privsize in here?

and then put the rest of the code factoring into separate patch,
so we can see clearly the change and the benefits

your new annotation_line__new should be renamed to something like
annotation_line__init ... we keep __new suffix for functions that
return new objects

thanks,
jirka

