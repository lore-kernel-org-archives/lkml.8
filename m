Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D808C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023E820771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="ADF7+uVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDGT5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:57:46 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:18696 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:57:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A6DCF3F423;
        Tue,  7 Apr 2020 21:57:42 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=ADF7+uVu;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id juSonQZZkhfi; Tue,  7 Apr 2020 21:57:41 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CBCE53F3F1;
        Tue,  7 Apr 2020 21:57:32 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8FBC3360153;
        Tue,  7 Apr 2020 21:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1586289452; bh=n8v3kP19wHdlpasfsqLzlqOfhDoVJzv2qXSEHg2XIUw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ADF7+uVugZlqdmK5afrGpG3q5imNSOSM3I40tdQMKpNd14xTelmYZ5CMsLyPXrfjN
         +XMf3b9C+ML4rnbmUkQ1nhVWV7VdVyHblKCmHYuUSFCagT/uOB+wwSM1N+yrpoCcQL
         wuCcY4doZST4CAMHbIY+PSnC6wwUdMVLMkIrRL/U=
Subject: Re: Bad rss-counter state from drm/ttm, drm/vmwgfx: Support huge TTM
 pagefaults
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-graphics-maintainer@vmware.com,
        Michal Hocko <mhocko@suse.com>, pv-drivers@vmware.com,
        Ralph Campbell <rcampbell@nvidia.com>,
        Roland Scheidegger <sroland@vmware.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1586138158.v5u7myprlp.none.ref@localhost>
 <1586138158.v5u7myprlp.none@localhost>
 <0b12b28c-5f42-b56b-ea79-6e3d1052b332@shipmail.org>
 <1586219716.1a3fyi6lh5.none@localhost>
 <37624a1f-8e6b-fe9c-8e0e-a9139e1bbe18@shipmail.org>
 <1586273767.0q72rozj3x.none@localhost>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <d6d9b4e6-3f73-a4df-68da-60ec9c0a3873@shipmail.org>
Date:   Tue, 7 Apr 2020 21:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1586273767.0q72rozj3x.none@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 5:36 PM, Alex Xu (Hello71) wrote:
> Excerpts from Thomas Hellström (VMware)'s message of April 7, 2020 7:26 am:
>> On 4/7/20 2:38 AM, Alex Xu (Hello71) wrote:
>>> Excerpts from Thomas Hellström (VMware)'s message of April 6, 2020 5:04 pm:
>>>> Hi,
>>>>
>>>> On 4/6/20 9:51 PM, Alex Xu (Hello71) wrote:
>>>>> Using 314b658 with amdgpu, starting sway and firefox causes "BUG: Bad
>>>>> rss-counter state" and "BUG: non-zero pgtables_bytes on freeing mm" to
>>>>> start filling dmesg, and then closing programs causes more BUGs and
>>>>> hangs, and then everything grinds to a halt (can't start more programs,
>>>>> can't even reboot through systemd).
>>>>>
>>>>> Using master and reverting that branch up to that point fixes the
>>>>> problem.
>>>>>
>>>>> I'm using a Ryzen 1600 and AMD Radeon RX 480 on an ASRock B450 Pro4
>>>>> board with IOMMU enabled.
>>>> If you could try the attached patch, that'd be great!
>>>>
>>>> Thanks,
>>>>
>>>> Thomas
>>>>
>>> Yeah, that works too. Kernel config sent off-list.
>>>
>>> Regards,
>>> Alex.
>> Thanks. Do you want me to add your
>>
>> Reported-by: and Tested-by: To this patch?
>>
>> /Thomas
>>
>>
> Sure. Shouldn't we fix it properly though?

It's still enabled for vmwgfx for which it is reasonably well tested and 
where I can't see any such errors.

The code we remove with this patch enables huge page-table entries in 
some circumstances for other drivers, but given the problems you're 
seeing for amdgpu, it's better to enable this on a per-driver basis 
after thorough testing. Since I don't have amdgpu hardware I'm not sure 
what it's doing differently, and can't debug the issue properly.

/Thomas


