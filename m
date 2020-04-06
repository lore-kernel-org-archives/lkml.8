Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F542206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="j4IsSgXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFU0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:26:05 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:46023 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:26:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A8CC343DF6;
        Mon,  6 Apr 2020 22:26:02 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=j4IsSgXC;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4SIvHs6jCMD6; Mon,  6 Apr 2020 22:26:01 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id AEB7B43DF7;
        Mon,  6 Apr 2020 22:25:53 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 00151360153;
        Mon,  6 Apr 2020 22:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1586204753; bh=WbUdhT5dg8z6hiyUYRS2nHJSvQqFxrl6lLG86/Mrvrw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j4IsSgXCnt5Bt0aXP9MiHm1kUCfwxku/J/HE5dUuMTKMOEMowSsbZEHrWcuUNN0yH
         WDg9Fkb77WT1LTTjQ+N2NawXF8q8m2i5RnfAxXl442JoAsMc1xjDwrnanD0DAp+Sbo
         SoUUE3bwPLSNgtYb+QJg2M+7TmotgzrwwCvNB0jk=
Subject: Re: Bad rss-counter state from drm/ttm, drm/vmwgfx: Support huge TTM
 pagefaults
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
References: <1586138158.v5u7myprlp.none.ref@localhost>
 <1586138158.v5u7myprlp.none@localhost>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <249c73d2-991a-56b0-53b5-677e9ca54aae@shipmail.org>
Date:   Mon, 6 Apr 2020 22:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1586138158.v5u7myprlp.none@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 9:51 PM, Alex Xu (Hello71) wrote:
> Using 314b658 with amdgpu, starting sway and firefox causes "BUG: Bad
> rss-counter state" and "BUG: non-zero pgtables_bytes on freeing mm" to
> start filling dmesg, and then closing programs causes more BUGs and
> hangs, and then everything grinds to a halt (can't start more programs,
> can't even reboot through systemd).
>
> Using master and reverting that branch up to that point fixes the
> problem.
>
> I'm using a Ryzen 1600 and AMD Radeon RX 480 on an ASRock B450 Pro4
> board with IOMMU enabled.

Hmm. That sounds bad. Could you send a copy of your config?

Meanwhile, I'll prepare a small patch that disables the non-vmwgfx 
huge_fault() until we've figured out what's happening.

/Thomas


