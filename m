Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BFA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcPGk7dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgG0HMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:12:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ACFC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:12:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l2so2225091pff.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4bixwfwct2k8xSCZVPHvs9nu1u1j6pLSKhgka678QeM=;
        b=hcPGk7dnyilX0AwUhmhxJdzZGdROIYNW8ufkHuNRw9P5LZunYCakJ74TtFIbMbDRjU
         qUzuVq8cVYBVhlCAjlatpMqAaPDt4WtupA4YvsaDqt9DblWR+nWx4IS8TARIQCnocYLh
         LUc5pGqAptJQDI0ZdSqfjCPXppCduI337dZRIDtF81hHOaSxGp8JRHnSXAROeqTwKH/1
         TuTbGRptSKj72gpKX657DYiY7ZxVrtE554g3ysSNizv4qPdDA4qssvFogX8Y0rEhOFns
         dxOGXa85TPuRlpWEtd+Gi4HnKwjVPaj2EfwvhbsH+1yjj7yKbZWBpL7wZy0Qi7JOeyKH
         3tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4bixwfwct2k8xSCZVPHvs9nu1u1j6pLSKhgka678QeM=;
        b=Q5/ZPZMQ4m0QhRPk17mz9l1WJ76Duq4467j2CyVnC0baLjFPys0lQm2iBuBNmNAcRo
         rd2gM8InivqMTAZT8x/OW/yskrzPLjjZa2rno9XhrPseMfv9oL0hx2lnsS5YXLopqwXb
         lQNLDopaTnldyCuZqkBBy6pVi2511JcMvuqLRc7cJ4RrFHBPrpLU3gFqwNxnQlyQOvvO
         bdL2ICHIvYiO8gjwzrkL0KsZ8efBEvfxEHmfzga3idRUYHTbyi++bvkz7/jgCxT6hfP9
         6oaWr3NxMFFCRIynqetIfU6fajptODKDsXMr+8meK/fr0iyWZdPOD7fBzaGmhvNRFDNW
         LwGQ==
X-Gm-Message-State: AOAM532PlU4J3ZtzuNTFqKunpWHW3wOqDRwQtAxDbx65sfl+wubrcA0z
        qwbbRHoakII/9DV4m/0BVK8=
X-Google-Smtp-Source: ABdhPJz8+8Dd/vfUGvoRNMOT4vmx8g8yI0bKHPLM+TEPHx52oF2+lplNDDBxAB1GifafTfORuUtniQ==
X-Received: by 2002:aa7:8d8b:: with SMTP id i11mr19321067pfr.263.1595833925328;
        Mon, 27 Jul 2020 00:12:05 -0700 (PDT)
Received: from endurance ([59.95.38.168])
        by smtp.gmail.com with ESMTPSA id z11sm14152867pfj.104.2020.07.27.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:12:04 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:41:59 +0530
From:   Nachiket Naganure <nachiketun8@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, lukas.bulwahn@gmail.com,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] checkpatch: disable commit log length check warning for
 signature tag
Message-ID: <20200727071159.GA595854@endurance>
References: <20200727055458.559558-1-nachiketun8@gmail.com>
 <66bbaec73d8f69541535db5390c0f12b304c0467.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bbaec73d8f69541535db5390c0f12b304c0467.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:14:42PM -0700, Joe Perches wrote:
> On Mon, 2020-07-27 at 11:24 +0530, Nachiket Naganure wrote:
> > Disable commit log length check in case of signature tag. If the commit
> > log line has valid signature tags such as "Reported-and-tested-by" with
> > more than 75 characters, suppress the long length warning.
> > 
> > For instance in commit ac854131d984 ("USB: core: Fix misleading driver bug
> > report"), the corresponding patch contains a "Reported by" tag line which
> > exceeds 75 chars. And there is no valid way to shorten the length.
> > 
> > Signed-off-by: Nachiket Naganure <nachiketun8@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 197436b20288..46237e9e0550 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2806,6 +2806,8 @@ sub process {
> >  					# filename then :
> >  		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
> >  					# A Fixes: or Link: line
> > +		      $line =~ /$signature_tags/ ||
> > +					# Check for signature_tags
> >  		      $commit_log_possible_stack_dump)) {
> >  			WARN("COMMIT_LOG_LONG_LINE",
> >  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> 
> OK, but the test should be:
> 
> 		      $line =~ /^\s*$signature_tags/ ||
> 
> so the line has to start with a signature and
> it won't match on signature tags in the middle
> of other content on the same line.
> 
> 
But the suggested won't work in case of merged signatures.
Such as "Reported-and-tested-by: user@email.com"

