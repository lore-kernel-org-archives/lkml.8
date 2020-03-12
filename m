Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB74206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584014320;
	bh=OIkjeJjP/YCoWeCBRAXVfoViIIsfub5U3Rq1ZIuGW1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dS2Uv9zdGiMYHNDaqu/sFq48JsY1AWSrDzxRcXY7VDLQ2r9N/yfKzSQdKW1Tol5jJ
	 Vf2N0Vvp6tFEtUeNyfnT9uACunQOcnB7TfDmPqaHbv+LKVltbZ7y4tH88LqXkhUp1Y
	 kdDFipyLCmEhAh2E7OWkPZoDZcQfkyICoiGZP7ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCLL6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgCLL6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:58:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280A520674;
        Thu, 12 Mar 2020 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584014316;
        bh=OIkjeJjP/YCoWeCBRAXVfoViIIsfub5U3Rq1ZIuGW1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6apPzV5nxMBU75W8Qu95EcdJwWvKENlXh+l1pWV7Sb0yXLGvi6/m6VPEWc0ROdsp
         AOYDCgcBLRaxXZW+RUvWEtn4iYS2wSnvfV9FazwGcD1TZXNyay9YKr+K81HuAGuRsK
         1r7h6gtJljYmwhZIF/DX+b/4jeaCSTvKYlPv1l4k=
Date:   Thu, 12 Mar 2020 12:58:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/170] 5.4.25-rc5 review
Message-ID: <20200312115834.GA235296@kroah.com>
References: <20200312062811.479223593@linuxfoundation.org>
 <d7c92c7c-7e50-fce8-ca6b-ced75561179f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c92c7c-7e50-fce8-ca6b-ced75561179f@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:03:08AM -0700, Guenter Roeck wrote:
> On 3/11/20 11:29 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.25 release.
> > There are 170 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 14 Mar 2020 06:27:28 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Five is the charm ...
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 422 pass: 422 fail: 0
> 
> Guenter

Finally!  Thanks for all of the testing and help here.

greg k-h
