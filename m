Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97819206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHcgSiAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEOEue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 00:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgEOEue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:50:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499AAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=1suKlg/yYVHHoAnz686r7kc2Q7SoBsoUeQ3pt0d2I8o=; b=jHcgSiAhsbeY2eMfRD2jZwRSW5
        f+StJVGQzn3FPwjhpPa8Or5WokVgBxm+U7KVYRWuwa8pvTmE4cBmPkvL/yuwHmDueChiBFGh4ZsLR
        4pcjl3hiOzjfNU9qqltZZIL3v9f/0WXnPywu9S32Zc5X1tjaDmwtODBkn2NBcmanRaJA2Td7ywnFG
        6Dn7iH3inKgOFuEAnJ16ktLGb3iXcaoXsbmDn/giMiK55hSkl0ze2+1pA8zO4HVEhpIq64ivQikWb
        TUaFCpNSIwipZA7lUwIxB+gvNIGDYDmTCY1VqhLaoHGbsYLOdGcVh8zc58xVBIEJdh7H5AizKzvaZ
        nFT4+s9w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZSIs-0003r4-2u; Fri, 15 May 2020 04:50:34 +0000
Subject: Re: [PATCH v4] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <25e7e777-19f9-6280-b456-6c9c782c7901@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e522825e-b2da-3cfe-7655-20c1c1975be4@infradead.org>
Date:   Thu, 14 May 2020 21:50:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <25e7e777-19f9-6280-b456-6c9c782c7901@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 9:04 PM, Rob Landley wrote:
> FYI I dug up my old https://lkml.org/lkml/2017/9/13/651 and ported it to
> current, because I needed it for a thing.
> 
> From: Rob Landley <rob@landley.net>
> 
> Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
> /dev/console open after devtmpfs mount.
> 
> Add workaround for Debian bug that was copied by Ubuntu.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> 

Hi Rob,

You need to send this patch to some maintainer who could merge it.

And it uses the wrong multi-line comment format.

cheers.
-- 
~Randy

