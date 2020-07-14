Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC53C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95283217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wpkm4yyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGNANM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:13:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4651FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:13:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so6783858pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iIGjOOcrG6YH/TItPZmLMnrrNFuue6zZLABbTH5Rg5w=;
        b=Wpkm4yyv9/VEYsbu9Qx6r1Qz5R2rJk1rmljMB6Y61NRCuVdDpbYfsQc+axqgabK8ka
         QoFPnsLugs42jR9TUnqjML74uRvSnJx/DJrivzvM4gHuAumJxGRnOuQpL03vYAEcTSua
         KTjs2DHwrQ6+sgEDQFILB9ruoCpdi49EVfHNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIGjOOcrG6YH/TItPZmLMnrrNFuue6zZLABbTH5Rg5w=;
        b=ny+3CfnKmjXOcKhTRm542fIo2/hZegISCOJnDnddE+FYh8639Ab6ZA1SSdJFw1CEcC
         VMopd7FC75fm/NsWCe2+tS2NCeWs3i0TWg4U744yCB1K79lLavV/khB8Y6wZ5h5gGK1x
         TUJGR1QPN6PfkiwTLzob0ZDi3mCACVVrcUUre89Pcuth3rxIaQRedAsYQhdlpxyw75GK
         //pZZDDKMsoFqP7cqClir0BlZEk5JC4+RcA/FY/iCXVtdc6Gw/xMkH8cwqop/SNylSnf
         8YUdoEu7GC89qzv1M10h323UZqmFYVmjbhhvPyMjGSecLvYoJ6XDDfWrS+TW3dQsfWNE
         ODHA==
X-Gm-Message-State: AOAM530iLm2csORxYNb74kXYVNXWGuyJDQrGNyKUnDBo783ucJfmb1RH
        LAMyGmdR+ehgNdfCpoS8hsHNKg==
X-Google-Smtp-Source: ABdhPJyOZiD2PxWSpJhmWCPmd45sNOcbmUN0o7IUu8siomP5nQOdHLhqW6cBw+3ARS7c7bbS5JWupw==
X-Received: by 2002:a65:448c:: with SMTP id l12mr1303444pgq.234.1594685589739;
        Mon, 13 Jul 2020 17:13:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i21sm15538735pfa.18.2020.07.13.17.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:13:08 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:13:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests/harness: Refactor XFAIL into SKIP
Message-ID: <202007131705.D17464CA16@keescook>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <20200622181651.2795217-7-keescook@chromium.org>
 <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:08:08PM -0700, Ralph Campbell wrote:
> 
> On 6/22/20 11:16 AM, Kees Cook wrote:
> > Plumb the old XFAIL result into a TAP SKIP.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   tools/testing/selftests/kselftest_harness.h   | 64 ++++++++++++++-----
> >   tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +--
> >   2 files changed, 52 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index f8f7e47c739a..b519765904a6 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -112,22 +112,22 @@
> >   			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
> >   /**
> > - * XFAIL(statement, fmt, ...)
> > + * SKIP(statement, fmt, ...)
> >    *
> > - * @statement: statement to run after reporting XFAIL
> > + * @statement: statement to run after reporting SKIP
> >    * @fmt: format string
> >    * @...: optional arguments
> >    *
> > - * This forces a "pass" after reporting a failure with an XFAIL prefix,
> > + * This forces a "pass" after reporting why something is being skipped
> >    * and runs "statement", which is usually "return" or "goto skip".
> >    */
> > -#define XFAIL(statement, fmt, ...) do { \
> > +#define SKIP(statement, fmt, ...) do { \
> >   	if (TH_LOG_ENABLED) { \
> > -		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
> > +		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
> >   			##__VA_ARGS__); \
> >   	} \
> > -	/* TODO: find a way to pass xfail to test runner process. */ \
> >   	_metadata->passed = 1; \
> > +	_metadata->skip = 1; \
> >   	_metadata->trigger = 0; \
> >   	statement; \
> >   } while (0)
> > @@ -777,6 +777,7 @@ struct __test_metadata {
> >   	struct __fixture_metadata *fixture;
> >   	int termsig;
> >   	int passed;
> > +	int skip;	/* did SKIP get used? */
> >   	int trigger; /* extra handler after the evaluation */
> >   	int timeout;	/* seconds to wait for test timeout */
> >   	bool timed_out;	/* did this test timeout instead of exiting? */
> > @@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
> >   		fprintf(TH_LOG_STREAM,
> >   			"# %s: Test terminated by timeout\n", t->name);
> >   	} else if (WIFEXITED(status)) {
> > -		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> >   		if (t->termsig != -1) {
> > +			t->passed = 0;
> >   			fprintf(TH_LOG_STREAM,
> >   				"# %s: Test exited normally instead of by signal (code: %d)\n",
> >   				t->name,
> >   				WEXITSTATUS(status));
> > -		} else if (!t->passed) {
> > -			fprintf(TH_LOG_STREAM,
> > -				"# %s: Test failed at step #%d\n",
> > -				t->name,
> > -				WEXITSTATUS(status));
> > +		} else {
> > +			switch (WEXITSTATUS(status)) {
> > +			/* Success */
> > +			case 0:
> > +				t->passed = 1;
> > +				break;
> > +			/* SKIP */
> > +			case 255:
> > +				t->passed = 1;
> > +				t->skip = 1;
> > +				break;
> > +			/* Other failure, assume step report. */
> > +			default:
> > +				t->passed = 0;
> > +				fprintf(TH_LOG_STREAM,
> > +					"# %s: Test failed at step #%d\n",
> > +					t->name,
> > +					WEXITSTATUS(status));
> > +			}
> >   		}
> >   	} else if (WIFSIGNALED(status)) {
> >   		t->passed = 0;
> > @@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
> >   {
> >   	/* reset test struct */
> >   	t->passed = 1;
> > +	t->skip = 0;
> >   	t->trigger = 0;
> >   	t->step = 0;
> >   	t->no_print = 0;
> > @@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
> >   		t->passed = 0;
> >   	} else if (t->pid == 0) {
> >   		t->fn(t, variant);
> > -		/* return the step that failed or 0 */
> > -		_exit(t->passed ? 0 : t->step);
> > +		/* Make sure step doesn't get lost in reporting */
> > +		if (t->step >= 255) {
> > +			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
> > +			t->step = 254;
> > +		}
> 
> I noticed that this message is now appearing in the HMM self tests.
> I haven't quite tracked down why ->steps should be 255 after running
> the first test. I did notice that ASSERT*() calls __INC_STEP() but
> that doesn't explain it.
> Separately, maybe __INC_STEP() should check for < 254 instead of < 255?
> 
>     Set CONFIG_HMM_TESTS=m, build and install kernel and modules.
>     cd tools/testing/selftests/vm
>     make
>     ./test_hmm.sh smoke
>     Running smoke test. Note, this test provides basic coverage.
>     [  106.803476] memmap_init_zone_device initialised 65536 pages in 7ms
>     [  106.810141] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3ffff0000 0x400000000)
>     [  106.823703] memmap_init_zone_device initialised 65536 pages in 4ms
>     [  106.829968] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3fffe0000 0x3ffff0000)
>     [  106.838655] HMM test module loaded. This is only for testing HMM.
>     TAP version 13
>     1..20
>     # Starting 20 tests from 3 test cases.
>     #  RUN           hmm.open_close ...
>     #            OK  hmm.open_close
>     ok 1 hmm.open_close
>     #  RUN           hmm.anon_read ...
>     # Too many test steps (255)!?
>     #            OK  hmm.anon_read

Oooh:

#define NTIMES          256

Yes, that's a lot of steps. :)

I agree,__ INC_STEP() needs adjustment, though it should be 253. Does
this work for you?

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 935029d4fb21..4f78e4805633 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -680,7 +680,8 @@
 			__bail(_assert, _metadata->no_print, _metadata->step))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed && _metadata->step < 255) \
+	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
+	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -976,12 +977,6 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* Make sure step doesn't get lost in reporting */
-		if (t->step >= 255) {
-			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
-			t->step = 254;
-		}
-		/* Use 255 for SKIP */
 		if (t->skip)
 			_exit(255);
 		/* Pass is exit 0 */

-- 
Kees Cook
