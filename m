Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D0C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BF62166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588330452;
	bh=0Cqvl5wkP/ieiQF2HFA2QygVgW3pCvJ1D9AWpPCWsIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PIogBFLVfOqCGKB9b/Uicn2Qb1PBaRmIzTYqSACg1X4VCJSHX8r1E2MkHv3rIakBi
	 pVI6DQej5MxOEmh26rSXKrDnnFEbxihUYhF2/XOD2Q59RG81QBhv8mpjwQdJhrkDej
	 II5I2dvJm7rTboryCg367rGc9jVMI1e+bgzFt4B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgEAKyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgEAKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:54:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CBA2076D;
        Fri,  1 May 2020 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588330450;
        bh=0Cqvl5wkP/ieiQF2HFA2QygVgW3pCvJ1D9AWpPCWsIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n0bXcwbUgL6TBLTqvsA2xwqNT8DodUpTxzgLWrhXiNgpenfU0AQgCG/72wsVtCmdi
         Ztk7WzpabT+Gs9SVTrNpDudBKnhy2iHda/QwX5Vm7YVG7vGY7jte5hFaT2LIGSoogi
         VPoECoDn//owdx1Ia58bFtHwfknjMsoNlDYPebok=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jUTJ2-008Jem-JB; Fri, 01 May 2020 11:54:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 May 2020 11:54:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, git@thegavinli.com,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
In-Reply-To: <20200501103712.GA51954@C02TD0UTHF1T.local>
References: <20200430211922.929165-1-jeremy.linton@arm.com>
 <20200501070500.GA887524@kroah.com>
 <20200501103712.GA51954@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <0aa2a8a9a5b6c00b2e1a1fcf71c121ce@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, gregkh@linuxfoundation.org, jeremy.linton@arm.com, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, git@thegavinli.com, jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 11:37, Mark Rutland wrote:
> On Fri, May 01, 2020 at 09:05:00AM +0200, Greg KH wrote:
>> On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
>> > On arm64, and possibly other architectures, requesting
>> > IO coherent memory may return Normal-NC if the underlying
>> > hardware isn't coherent. If these pages are then
>> > remapped into userspace as Normal, that defeats the
>> > purpose of getting Normal-NC, as well as resulting in
>> > mappings with differing cache attributes.
>> 
>> What is "Normal-NC"?
> 
> Arm terminology for "Normal Non-Cacheable"; it might be better to say
> something like:
> 
> On some architectures (e.g. arm64) an IO coherent mapping may use
> non-cachable attributes if the relevant device is cache coherent.

is *not* cache coherent.

> If userspace mappings are cacheable, these may not be coherent with
> non-cacheable mappings. On arm64 this is the case for Normal-NC and
> Normal (cacheable) mappings.

And to answer some of Greg's questions:

- This can show up on current HW that doesn't offer full IO coherency,
   which is likely on low-end arm/arm64 systems.

- I guess nobody noticed this before as x86 is perfectly happy with
   conflicting attributes for the same physical page, and there is
   (wild guess) probably not that much userspace making use of shared
   mappings between kernel and userspace using this interface.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
