Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F52F20748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V4CqoOj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgCaAna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:43:30 -0400
Received: from m12-13.163.com ([220.181.12.13]:51597 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgCaAna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=XjsT7
        mbIv2Q1KnZdpBGcBJwAuWn6TTxNoV1RazGC+qQ=; b=V4CqoOj1KAXP0u9xOkBl3
        LTLR00BoMS4N3i4AMf6yOr+hFjaONVCvW606eYcU0GN3j7D3cU0porCDlP5Cazmg
        Nv/i3IZiISwAzjKidKlFxL92lhjvH7H1iJpUiuQbGnbYuTO/hyeUoTsDlcAZnvh4
        Qj9ePeCSYtO6Sc+ezaEsh4=
Received: from [192.168.0.6] (unknown [125.82.11.174])
        by smtp9 (Coremail) with SMTP id DcCowADHzuYokoJeji0aBw--.4264S2;
        Tue, 31 Mar 2020 08:43:21 +0800 (CST)
Subject: Re: [PATCH] arch/xtensa: correct an ungrammatical word
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200330045436.12645-1-xianfengting221@163.com>
 <CAMo8BfLQuKHsqM5yb0N6cfquCoXR17rnkt+TXG01Fkz-Po1pqw@mail.gmail.com>
From:   Hu Haowen <xianfengting221@163.com>
Message-ID: <a4297848-1685-a3d1-43cc-05e9f4cecbb7@163.com>
Date:   Tue, 31 Mar 2020 08:43:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLQuKHsqM5yb0N6cfquCoXR17rnkt+TXG01Fkz-Po1pqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: DcCowADHzuYokoJeji0aBw--.4264S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaAwIDUUUU
X-Originating-IP: [125.82.11.174]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/xtbB0Qn3AFzH9HLg3gAAsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/31 4:33 AM, Max Filippov wrote:
> On Sun, Mar 29, 2020 at 9:55 PM Hu Haowen <xianfengting221@163.com> wrote:
>> The word "Dont" is not grammatical. Maybe it means "Don't".
>>
>> Signed-off-by: Hu Haowen <xianfengting221@163.com>
>> ---
>>   arch/xtensa/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Thanks, applied to my xtensa tree with a slightly modified subject
> line/description.
>
> -- Max
You are welcome.

