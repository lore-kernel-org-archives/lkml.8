Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F31C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13EE20724
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/QdLsfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgDQQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDQQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:53:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:53:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b62so3107970qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GNIlelglTBWj9ou9+913/T+QOR7GIyLWPXRoUBr1w6A=;
        b=i/QdLsfK3u7V14whDbmHCoAmQ/vVS8c4ZwHOpfEFhrXRog/a/aWloM/s3obbV0WoO8
         cAi6s/+Sftduq2YE7tejVymZVUBNVzncMLxCbZrOU19JeCVmlx0k5mUKQPGIb+q858EI
         wf7O6Ug+tZ6jIM04v8S+5qL/Ux+T2ghBWgc9/hwBIDeTLNTuCKm5M5mT4E4l+79jUB1p
         EbgO5DcjjjIWyMYm+guSXOPNaMdwGnIyrinBIbMVdynTrxSipcDL7V6WuYMK4S8YxiUn
         D3ZSagfX5JhUACFfbQvTYXrBWoOxn5SIsT3KKUqbRiEr7zPFiTzdZKlPEjsNOV+NhbJf
         CpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GNIlelglTBWj9ou9+913/T+QOR7GIyLWPXRoUBr1w6A=;
        b=WipeIak3dpF6RF8lv3OvaI8GIPSaS8x4z9m2TW6oiMnXym5oKVYFImixQLoRnn5vN1
         fFP5JT6K2mE++z4vM6RwHN85gDOCAiQvn5TIixwmPF+6o9+/2CbEIqstLcS/SQTzJxJP
         4x0OEK81cHsSYwIM/MrX9x2pNz+cGcXqDujP2/O8Z3QrMvU9VJ0ZDaOfAmvnBe+Mt4Pv
         2XIxv1sRSE0mtHYGjy6MEGVt5sjh18I2Q3wjo10cFBQBa4MS5zIsE31NlunG3kf/PQ0E
         YwZOvDoPQPvqT3FBF1JI9F0vRrfkvkFfqCrWZhJBaN65je3yfv8YDwS2W0SpE8X/iSiW
         r8SA==
X-Gm-Message-State: AGi0Pua6Ax8WsD2cAmKE5QS4CMokkelw7lhpJiczRi+QC8Fge3tXJ9YI
        9jnHITHwA3NZomr3CMuwp0c=
X-Google-Smtp-Source: APiQypJgYx48SZ1DAO4oPEHtTj2bh+RA3aDWDlFL/r6CpPvvMZYXOIQMPdpZZcmz08VsmyinBNOKlA==
X-Received: by 2002:ae9:e854:: with SMTP id a81mr4203190qkg.36.1587142412365;
        Fri, 17 Apr 2020 09:53:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h128sm17037444qkd.17.2020.04.17.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:53:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74D1B409A3; Fri, 17 Apr 2020 13:53:29 -0300 (-03)
Date:   Fri, 17 Apr 2020 13:53:29 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 11/17] perf tools: Save previous cursor nodes for LBR
 stitching approach
Message-ID: <20200417165329.GE17973@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200319202517.23423-12-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-12-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 01:25:11PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The cursor nodes which generates from sample are eventually added into
> callchain. To avoid generating cursor nodes from previous samples again,
> the previous cursor nodes are also saved for LBR stitching approach.
> 
> Some option, e.g. hide-unresolved, may hide some LBRs.
> Add a variable 'valid' in struct callchain_cursor_node to indicate this
> case. The LBR stitching approach will only append the valid cursor nodes
> from previous samples later.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Applied this on top:


diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6e7f15b45389..737dee723a57 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2364,8 +2364,7 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	return true;
 
 free_lbr_stitch:
-	free(thread->lbr_stitch);
-	thread->lbr_stitch = NULL;
+	zfree(&thread->lbr_stitch);
 err:
 	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
 	thread->lbr_stitch_enable = false;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index c2eb3f943724..8456174a52c5 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -161,7 +161,7 @@ static inline void thread__free_stitch_list(struct thread *thread)
 	if (!lbr_stitch)
 		return;
 
-	free(lbr_stitch->prev_lbr_cursor);
+	zfree(&lbr_stitch->prev_lbr_cursor);
 	zfree(&thread->lbr_stitch);
 }
 
