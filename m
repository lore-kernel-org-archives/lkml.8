Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D574FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86423246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="lhePlhD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1M3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:29:07 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:44559 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1M3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PqSQKcoq859PmNsBN7wYEqganIU4/zW+nvRfanijCh8=; b=lhePlhD+NMzVw6YHN9VFoz7n6h
        p+YBCd1EqoTyB43T+hFRiT0Qo9TmsmkACFxUfzQqNjaM6S/aKKH9q2HQSzuej7YoVYyfErmHwFlwm
        7i5fCuasfOxwO4FA0Svdn5dRTcBOO8eiY5bb1puuxnFbuydwaWT/zG0U2VbObuu3rkIjg227gOV80
        BR4zMFta5FsVjviNJO/iZsUEYQzu2g/6W6hnYkgnwlx2DrtqYdhgrqP//v3qC3Gxbj0dFwwr0l1v4
        ERpWIAJJUBc0a82Db7ek/LsKu2oBFn6Z55dKOnvyV1AjFbAmZHxKWFNRtmCTsMUdmoyziCsRgdh05
        /b4xXFdA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49401 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1j7elM-0005it-7Q; Fri, 28 Feb 2020 13:29:04 +0100
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
To:     Emmanuel Vadot <manu@bidouilliste.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, efremov@linux.com,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sam@ravnborg.org, tzimmermann@suse.de
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-2-manu@FreeBSD.org> <877e0n66qi.fsf@intel.com>
 <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
 <20200225091810.1de39ea4e0d578d363420412@bidouilliste.com>
 <20200225170313.GM2363188@phenom.ffwll.local>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2a735cb0-5a78-8dcf-dcaa-30f5a5f77e2d@tronnes.org>
Date:   Fri, 28 Feb 2020 13:28:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225170313.GM2363188@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 25.02.2020 18.03, skrev Daniel Vetter:
> On Tue, Feb 25, 2020 at 09:18:10AM +0100, Emmanuel Vadot wrote:
>> On Mon, 24 Feb 2020 11:40:38 +0000
>> Chris Wilson <chris@chris-wilson.co.uk> wrote:
>>
>>> Quoting Jani Nikula (2020-02-15 18:33:09)
>>>> On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
>>>>> From: Emmanuel Vadot <manu@FreeBSD.Org>
>>>>>
>>>>> Contributors for this file are :
>>>>> Chris Wilson <chris@chris-wilson.co.uk>
>>>>> Denis Efremov <efremov@linux.com>
>>>>> Jani Nikula <jani.nikula@intel.com>
>>>>> Maxime Ripard <mripard@kernel.org>
>>>>> Noralf Trønnes <noralf@tronnes.org>
>>>>> Sam Ravnborg <sam@ravnborg.org>
>>>>> Thomas Zimmermann <tzimmermann@suse.de>
>>>>>
>>>>> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
>>>>
>>>> I've only converted some logging.
>>>>
>>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>>
>>> Bonus ack from another Intel employee to cover all Intel copyright in
>>> this file,
>>> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
>>> -Chris
>>
>>  Thanks Chris,
>>
>>  Daniel, if I'm counting right this was the last ack needed.
> 
> I'm counting the same, patch applied and thanks for taking care of the
> paperwork pushing here.
> 

Looks like it got lost somehow, I can't find it in drm-tip at least.

Noralf.

> Thanks, Daniel
> 
