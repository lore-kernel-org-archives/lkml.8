Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6825C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E61F206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH8mE8A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgEKUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:20:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B40C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:20:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s186so9426524qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=R8nilJ4CcTJaHyQ3czgk5Dtf5WYQNvIraDoZesffuVY=;
        b=nH8mE8A/qTjN7djkR2O9CuROi0sRqXXH+kuYM02WhAUFhSKbrbaWmd9efEyVKLUl/C
         Oar5s9QwcAZzMDq6elXFjZzfR5sdR3LPV7oLoPa2+2DgCfoEou2LR20ptdh4kNWtr3LX
         frMqxT64LCA0uU9Ga75P6ufOlrxrPelcGACDwkAYbkuML1X11n0v7yrLdBba+Wqn0d1b
         ArCmrRxsh4wZEyE2+8je06bORCnUdCZoAwY/CR1HUEqrbIHsoAceR/pTFHtwVwYpPVRx
         o680cCK6qVNLOUU2gbSkOcUlHTr+P07aWyd1i9RVEqsqHLquK/esQ2zphwATqm8jo0K0
         VzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=R8nilJ4CcTJaHyQ3czgk5Dtf5WYQNvIraDoZesffuVY=;
        b=PtepANnaHRGO/TiPw1YJeUNc+r09baHRfn5ZAoHo+48rtBBwUHLAFta90Hi1zTURTD
         fOhOQDiK4S7qjjMjmSnlrknbWtZo0wBxRnjEvtJ8l057ZS8ObAnS3VgDWt1ROVBKrq5P
         hx5M9IKyi7wgreXsBQAgdhiLTWJXQ1Li+FoOHUKw3U0765as7gJiQbgNrEv6TBw+RcWv
         ywW7DCp1LTu8uuuB+TAtRnRerSRIATCnsoluryF9WXB6qBx0pV1fofPOoh/yvxnO5K9+
         v2enBGnKgIh8ythZyHXvZVGul9/JG+OEs0mDM+opYttTTVnccU8UitzbChX+JD8vb6ki
         OTRw==
X-Gm-Message-State: AGi0PubR5WqHVg4f4fPoWZsptT9m6M5HLILB/9WNyyqvzgSdjoB5mJeg
        zcHPe840R9MecDQ+j4FTBdUf1/RK
X-Google-Smtp-Source: APiQypL8tblGtMBDY6G1sq+WK++Zg3S0NYkPjRDKgFvw2OPBQBxyOCQZUUn5nK/y6PEPk6zCKInNzw==
X-Received: by 2002:a37:9d4f:: with SMTP id g76mr8410016qke.235.1589228420346;
        Mon, 11 May 2020 13:20:20 -0700 (PDT)
Received: from [10.94.16.134] (189-94-128-6.3g.claro.net.br. [189.94.128.6])
        by smtp.gmail.com with ESMTPSA id t21sm2566873qtb.0.2020.05.11.13.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 13:20:19 -0700 (PDT)
Date:   Mon, 11 May 2020 17:20:08 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200511195643.GA9850@embeddedor>
References: <20200511195643.GA9850@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 11, 2020 4:56:43 PM GMT-03:00, "Gustavo A=2E R=2E Silva" <gustavoar=
s@kernel=2Eorg> wrote:
>The current codebase makes use of the zero-length array language
>extension to the C90 standard, but the preferred mechanism to declare
>variable-length types such as these ones is a flexible array
>member[1][2],
>introduced in C99:
>
>struct foo {
>        int stuff;
>        struct boo array[];
>};
>
>By making use of the mechanism above, we will get a compiler warning
>in case the flexible array does not occur last in the structure, which
>will help us prevent some kind of undefined behavior bugs from being
>inadvertently introduced[3] to the codebase from now on=2E
>
>Also, notice that, dynamic memory allocations won't be affected by
>this change:
>
>"Flexible array members have incomplete type, and so the sizeof
>operator
>may not be applied=2E As a quirk of the original implementation of
>zero-length arrays, sizeof evaluates to zero=2E"[1]
>
>sizeof(flexible-array-member) triggers a warning because flexible array
>members have incomplete type[1]=2E There are some instances of code in
>which the sizeof operator is being incorrectly/erroneously applied to
>zero-length arrays and the result is zero=2E Such instances may be hiding
>some bugs=2E So, this work (flexible-array member conversions) will also
>help to get completely rid of those sorts of issues=2E
>
>This issue was found with the help of Coccinelle=2E

Thanks, applied

- Arnaldo
>
>[1] https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Zero-Length=2Ehtml
>[2] https://github=2Ecom/KSPP/linux/issues/21
>[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
>Signed-off-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>
>---
> tools/perf/bench/sched-messaging=2Ec       | 2 +-
> tools/perf/builtin-inject=2Ec              | 2 +-
> tools/perf/builtin-script=2Ec              | 2 +-
> tools/perf/builtin-timechart=2Ec           | 2 +-
> tools/perf/util/annotate=2Eh               | 4 ++--
> tools/perf/util/branch=2Eh                 | 2 +-
> tools/perf/util/cputopo=2Eh                | 2 +-
> tools/perf/util/dso=2Eh                    | 4 ++--
> tools/perf/util/event=2Eh                  | 2 +-
> tools/perf/util/jitdump=2Ec                | 2 +-
> tools/perf/util/jitdump=2Eh                | 6 +++---
> tools/perf/util/ordered-events=2Eh         | 2 +-
> tools/perf/util/pstack=2Ec                 | 2 +-
> tools/perf/util/symbol=2Eh                 | 2 +-
> tools/perf/util/unwind-libunwind-local=2Ec | 2 +-
> 15 files changed, 19 insertions(+), 19 deletions(-)
>
>diff --git a/tools/perf/bench/sched-messaging=2Ec
>b/tools/perf/bench/sched-messaging=2Ec
>index 97e4a4fb3362=2E=2E71d830d7b923 100644
>--- a/tools/perf/bench/sched-messaging=2Ec
>+++ b/tools/perf/bench/sched-messaging=2Ec
>@@ -40,7 +40,7 @@ struct sender_context {
> 	unsigned int num_fds;
> 	int ready_out;
> 	int wakefd;
>-	int out_fds[0];
>+	int out_fds[];
> };
>=20
> struct receiver_context {
>diff --git a/tools/perf/builtin-inject=2Ec b/tools/perf/builtin-inject=2E=
c
>index 7e124a7b8bfd=2E=2E8f983877c42d 100644
>--- a/tools/perf/builtin-inject=2Ec
>+++ b/tools/perf/builtin-inject=2Ec
>@@ -51,7 +51,7 @@ struct perf_inject {
> struct event_entry {
> 	struct list_head node;
> 	u32		 tid;
>-	union perf_event event[0];
>+	union perf_event event[];
> };
>=20
>static int output_bytes(struct perf_inject *inject, void *buf, size_t
>sz)
>diff --git a/tools/perf/builtin-script=2Ec b/tools/perf/builtin-script=2E=
c
>index 1f57a7ecdf3d=2E=2E02d64a9c6f64 100644
>--- a/tools/perf/builtin-script=2Ec
>+++ b/tools/perf/builtin-script=2Ec
>@@ -2619,7 +2619,7 @@ static int __cmd_script(struct perf_script
>*script)
> struct script_spec {
> 	struct list_head	node;
> 	struct scripting_ops	*ops;
>-	char			spec[0];
>+	char			spec[];
> };
>=20
> static LIST_HEAD(script_specs);
>diff --git a/tools/perf/builtin-timechart=2Ec
>b/tools/perf/builtin-timechart=2Ec
>index 9e84fae9b096=2E=2E0ba568efa939 100644
>--- a/tools/perf/builtin-timechart=2Ec
>+++ b/tools/perf/builtin-timechart=2Ec
>@@ -128,7 +128,7 @@ struct sample_wrapper {
> 	struct sample_wrapper *next;
>=20
> 	u64		timestamp;
>-	unsigned char	data[0];
>+	unsigned char	data[];
> };
>=20
> #define TYPE_NONE	0
>diff --git a/tools/perf/util/annotate=2Eh b/tools/perf/util/annotate=2Eh
>index 2d88069d6428=2E=2E0a0cd4f32175 100644
>--- a/tools/perf/util/annotate=2Eh
>+++ b/tools/perf/util/annotate=2Eh
>@@ -144,7 +144,7 @@ struct annotation_line {
> 	u32			 idx;
> 	int			 idx_asm;
> 	int			 data_nr;
>-	struct annotation_data	 data[0];
>+	struct annotation_data	 data[];
> };
>=20
> struct disasm_line {
>@@ -227,7 +227,7 @@ void symbol__calc_percent(struct symbol *sym,
>struct evsel *evsel);
> struct sym_hist {
> 	u64		      nr_samples;
> 	u64		      period;
>-	struct sym_hist_entry addr[0];
>+	struct sym_hist_entry addr[];
> };
>=20
> struct cyc_hist {
>diff --git a/tools/perf/util/branch=2Eh b/tools/perf/util/branch=2Eh
>index 154a05cd03af=2E=2E748f1d23a5c4 100644
>--- a/tools/perf/util/branch=2Eh
>+++ b/tools/perf/util/branch=2Eh
>@@ -41,7 +41,7 @@ struct branch_entry {
> struct branch_stack {
> 	u64			nr;
> 	u64			hw_idx;
>-	struct branch_entry	entries[0];
>+	struct branch_entry	entries[];
> };
>=20
> /*
>diff --git a/tools/perf/util/cputopo=2Eh b/tools/perf/util/cputopo=2Eh
>index 7bf6b811f715=2E=2E6201c3790d86 100644
>--- a/tools/perf/util/cputopo=2Eh
>+++ b/tools/perf/util/cputopo=2Eh
>@@ -22,7 +22,7 @@ struct numa_topology_node {
>=20
> struct numa_topology {
> 	u32				nr;
>-	struct numa_topology_node	nodes[0];
>+	struct numa_topology_node	nodes[];
> };
>=20
> struct cpu_topology *cpu_topology__new(void);
>diff --git a/tools/perf/util/dso=2Eh b/tools/perf/util/dso=2Eh
>index 2db64b79617a=2E=2Ed7ba29ad19ff 100644
>--- a/tools/perf/util/dso=2Eh
>+++ b/tools/perf/util/dso=2Eh
>@@ -136,7 +136,7 @@ struct dso_cache {
> 	struct rb_node	rb_node;
> 	u64 offset;
> 	u64 size;
>-	char data[0];
>+	char data[];
> };
>=20
> struct auxtrace_cache;
>@@ -208,7 +208,7 @@ struct dso {
> 	struct nsinfo	*nsinfo;
> 	struct dso_id	 id;
> 	refcount_t	 refcnt;
>-	char		 name[0];
>+	char		 name[];
> };
>=20
> /* dso__for_each_symbol - iterate over the symbols of given type
>diff --git a/tools/perf/util/event=2Eh b/tools/perf/util/event=2Eh
>index b8289f160f07=2E=2E6ae01c3c2ffa 100644
>--- a/tools/perf/util/event=2Eh
>+++ b/tools/perf/util/event=2Eh
>@@ -79,7 +79,7 @@ struct sample_read {
>=20
> struct ip_callchain {
> 	u64 nr;
>-	u64 ips[0];
>+	u64 ips[];
> };
>=20
> struct branch_stack;
>diff --git a/tools/perf/util/jitdump=2Ec b/tools/perf/util/jitdump=2Ec
>index e3ccb0ce1938=2E=2E32bb05e03fb2 100644
>--- a/tools/perf/util/jitdump=2Ec
>+++ b/tools/perf/util/jitdump=2Ec
>@@ -57,7 +57,7 @@ struct debug_line_info {
> 	unsigned long vma;
> 	unsigned int lineno;
>	/* The filename format is unspecified, absolute path, relative etc=2E */
>-	char const filename[0];
>+	char const filename[];
> };
>=20
> struct jit_tool {
>diff --git a/tools/perf/util/jitdump=2Eh b/tools/perf/util/jitdump=2Eh
>index f2c3823cc81a=2E=2Eab2842def83d 100644
>--- a/tools/perf/util/jitdump=2Eh
>+++ b/tools/perf/util/jitdump=2Eh
>@@ -93,7 +93,7 @@ struct debug_entry {
> 	uint64_t addr;
> 	int lineno;	    /* source line number starting at 1 */
> 	int discrim;	    /* column discriminator, 0 is default */
>-	const char name[0]; /* null terminated filename, \xff\0 if same as
>previous entry */
>+	const char name[]; /* null terminated filename, \xff\0 if same as
>previous entry */
> };
>=20
> struct jr_code_debug_info {
>@@ -101,7 +101,7 @@ struct jr_code_debug_info {
>=20
> 	uint64_t code_addr;
> 	uint64_t nr_entry;
>-	struct debug_entry entries[0];
>+	struct debug_entry entries[];
> };
>=20
> struct jr_code_unwinding_info {
>@@ -110,7 +110,7 @@ struct jr_code_unwinding_info {
> 	uint64_t unwinding_size;
> 	uint64_t eh_frame_hdr_size;
> 	uint64_t mapped_size;
>-	const char unwinding_data[0];
>+	const char unwinding_data[];
> };
>=20
> union jr_entry {
>diff --git a/tools/perf/util/ordered-events=2Eh
>b/tools/perf/util/ordered-events=2Eh
>index 0920fb0ec6cc=2E=2E75345946c4b9 100644
>--- a/tools/perf/util/ordered-events=2Eh
>+++ b/tools/perf/util/ordered-events=2Eh
>@@ -29,7 +29,7 @@ typedef int (*ordered_events__deliver_t)(struct
>ordered_events *oe,
>=20
> struct ordered_events_buffer {
> 	struct list_head	list;
>-	struct ordered_event	event[0];
>+	struct ordered_event	event[];
> };
>=20
> struct ordered_events {
>diff --git a/tools/perf/util/pstack=2Ec b/tools/perf/util/pstack=2Ec
>index 80ff41fc45be=2E=2Ea1d1e4ef6257 100644
>--- a/tools/perf/util/pstack=2Ec
>+++ b/tools/perf/util/pstack=2Ec
>@@ -15,7 +15,7 @@
> struct pstack {
> 	unsigned short	top;
> 	unsigned short	max_nr_entries;
>-	void		*entries[0];
>+	void		*entries[];
> };
>=20
> struct pstack *pstack__new(unsigned short max_nr_entries)
>diff --git a/tools/perf/util/symbol=2Eh b/tools/perf/util/symbol=2Eh
>index 93fc43db1be3=2E=2Eff4f4c47e148 100644
>--- a/tools/perf/util/symbol=2Eh
>+++ b/tools/perf/util/symbol=2Eh
>@@ -55,7 +55,7 @@ struct symbol {
> 	u8		inlined:1;
> 	u8		arch_sym;
> 	bool		annotate2;
>-	char		name[0];
>+	char		name[];
> };
>=20
> void symbol__delete(struct symbol *sym);
>diff --git a/tools/perf/util/unwind-libunwind-local=2Ec
>b/tools/perf/util/unwind-libunwind-local=2Ec
>index b4649f5a0c2f=2E=2E9aededc0bc06 100644
>--- a/tools/perf/util/unwind-libunwind-local=2Ec
>+++ b/tools/perf/util/unwind-libunwind-local=2Ec
>@@ -243,7 +243,7 @@ struct eh_frame_hdr {
> 	 *    encoded_t fde_addr;
> 	 * } binary_search_table[fde_count];
> 	 */
>-	char data[0];
>+	char data[];
> } __packed;
>=20
>static int unwind_spec_ehframe(struct dso *dso, struct machine
>*machine,

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
