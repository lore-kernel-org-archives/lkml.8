Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB715C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DF22084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590588531;
	bh=KgWzi/exVD9XKcH/pOPqFWrhMHncNBy+WOWVvFa+/Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VBVLk8iiY/xi1DjdEPUo+HgRblhvzFOfBT+sBb5SMuomjeUQr2YIdIMCGpcE3ZXdB
	 CYL0Mu5ueszDP6dbjsPCqRDY82mu5DQG4Tzb0Y2qNmwl8dAhfQjUPhD5c+kA+v3KVM
	 A6F1QEJcZ88YK+B2R9RY4jMh2PbtoWQ5rdsIvtr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbgE0OIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbgE0OIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:08:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF00207D3;
        Wed, 27 May 2020 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590588529;
        bh=KgWzi/exVD9XKcH/pOPqFWrhMHncNBy+WOWVvFa+/Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/Vrp2O17B6H6lNAxUhQ8tL7QeVByIybaV/QSI/Ystron9Mf24WSQine408FcML4y
         0vCpjarEJW6c90phjbLV2vUfT1QqXCocZTFvZT28wFc4/782oZkbu5Ofb4wakm5Wcm
         DnKgLqFT87n4ItmtdULQ0NcpCWc4rjmOJ/+rSAU4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A1F1F40AFD; Wed, 27 May 2020 11:08:45 -0300 (-03)
Date:   Wed, 27 May 2020 11:08:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf jvmti: Do not report error when missing debug
 information
Message-ID: <20200527140845.GA16326@kernel.org>
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427061520.24905-3-nick.gasson@arm.com>
 <20200527140753.GD14219@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527140753.GD14219@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 27, 2020 at 11:07:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Apr 27, 2020 at 02:15:15PM +0800, Nick Gasson escreveu:
> > If the Java sources are compiled with -g:none to disable debug
> > information the perf JVMTI plugin reports a lot of errors like:
> > 
> >   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> >   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> >   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> >   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> >   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> > 
> > Instead if GetLineNumberTable returns JVMTI_ERROR_ABSENT_INFORMATION
> > simply skip emitting line number information for that method. Unlike the
> > previous patch these errors don't affect the jitdump generation, they
> > just generate a lot of noise.
> > 
> > Similarly for native methods which also don't have line tables.
> > 
> > Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> > ---
> >  tools/perf/jvmti/libjvmti.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> > index 50ef524b5cd4..a9a056d68416 100644
> > --- a/tools/perf/jvmti/libjvmti.c
> > +++ b/tools/perf/jvmti/libjvmti.c
> > @@ -41,7 +41,11 @@ do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
> >  	jvmtiError ret;
> >  
> >  	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
> > -	if (ret != JVMTI_ERROR_NONE) {
> > +	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
> > +		/* No debug information for this method */
> > +		*nr = 0;
> > +		return JVMTI_ERROR_NONE;
> > +	} else if (ret != JVMTI_ERROR_NONE) {
> >  		print_error(jvmti, "GetLineNumberTable", ret);
> >  		return ret;
> >  	}
> > @@ -93,6 +97,9 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
> >  					/* free what was allocated for nothing */
> >  					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
> >  					nr_total += (int)nr;
> > +				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
> > +					   || ret == JVMTI_ERROR_NATIVE_METHOD) {
> 
> Please add the || operator at the end of the line next time, I'm fixing
> this up this time,
> 
> Applied,

This:

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index a9a056d68416..c5d30834a64c 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -97,8 +97,8 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 					/* free what was allocated for nothing */
 					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
 					nr_total += (int)nr;
-				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
-					   || ret == JVMTI_ERROR_NATIVE_METHOD) {
+				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION ||
+					   ret == JVMTI_ERROR_NATIVE_METHOD) {
 					/* No debug information for this method */
 				} else {
 					print_error(jvmti, "GetLineNumberTable", ret);
