Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9920724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="T/+0z1AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:00:39 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:21222 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1593802839;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Tix1KqcnGSpTs/4i5cgNqmCJm4LTps81dPDADxlsRVo=;
  b=T/+0z1AQYJdkjezMHqCPBWIjqFBSQYp8qM1ldxte7TdUUjfUllBtiXoB
   fuIBWzLjTC7tHx4jFxgOoem05cb5q6Zm8qO4BfJbE8sl7UGBJ4VeilZy1
   3dGrGQQXcD0U4yOi1r5ZtxoMaKF5SoS8PICfMsl51/dxUJkyXHyImEQX9
   s=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 5WTuxR1voOIMGz0oLmdUfxkYHROzepZ+qF33kK2R2c6IQ1B1tr1zWHfj5qvsyiP9y5+RaSkdW+
 tKLciEDOcWDjO0YuOTv5lbFwMLrsukaJ1P4Njz8+Z4Yj/4fiqnqxHTLbYeVp7XXsEvHxtG0oCl
 oy64kpifYfaxKe7rhOOskFUzW+c45w1L4s3cM7ivr9bCFFB0xh8ekXbj9y0tjnMbvXJwdpMhee
 K6whlj8Kbilhf71H9pMDDJoFRF1CyhdSqjzSVTB2GNRgqB7MpMCTj2kJwfroxK+Tzw8K+H8YRc
 AXY=
X-SBRS: 2.7
X-MesageID: 21573706
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,308,1589256000"; 
   d="scan'208";a="21573706"
Subject: Re: [PATCH entry v2 5/6] x86/ldt: Disable 16-bit segments on Xen PV
To:     Andy Lutomirski <luto@kernel.org>, <x86@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
 <92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <87fc68cf-540a-85e1-4dde-80cb3e82c3a5@citrix.com>
Date:   Fri, 3 Jul 2020 20:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 18:02, Andy Lutomirski wrote:
> Xen PV doesn't implement ESPFIX64, so they don't work right.  Disable
> them.  Also print a warning the first time anyone tries to use a
> 16-bit segment on a Xen PV guest that would otherwise allow it
> to help people diagnose this change in behavior.
>
> This gets us closer to having all x86 selftests pass on Xen PV.

Do we know exactly how much virtual address space ESPFIX64 takes up?

Are people going to scream in horror if Linux needs to donate some
virtual address space back to Xen to get this working?  Linux's current
hypervisor range (8TB, 16 pagetable slots) really isn't enough for some
systems these days.

~Andrew
