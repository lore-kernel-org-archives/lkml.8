Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0021C21775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 08:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Lw3x1xub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgGRIoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 04:44:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA15C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:44:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so15252231ljm.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjE+dCvxgE0tlMMZLFwfonoavKmjK5fkX5+I71udzRw=;
        b=Lw3x1xub/THf0lSfQiJLlYPDEeLqTRfWGY1OSES/r9EWhLdZ/OwMUm17mmqb9cXSAj
         a0Q7tFEG6di06ImL47HCTr8cC1xh7u5JdmmLgQQEGUOaq1PL/e+0MpLgvqO8+yQ4so6p
         V7wYvcSXVkXtZFW004PAwBCJlrHTe0Wb42SUR7GkZINg/22/eCy/11e0gWLdwfFsZcQx
         3mxtU4Me1jb2j+W0r0BKZnqWwTT/XFyhZGTz8Ze0E52XTH8w4biUSIAbi5skzZCqtzW+
         t6/tCcKUad/PMx/fE64be9uvxnDRZbj9q8QeHSvLvlWOQqXcva+e2R12H4AUAIo/ZxEO
         aURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjE+dCvxgE0tlMMZLFwfonoavKmjK5fkX5+I71udzRw=;
        b=GMJkWrrEr4Zrme/0QmbTS9kpGysEKir5OJN8oni0pbuuEaz9oa9W1GtUiAjT9wnah3
         65CWfw9N/3VKo7vx1ZyxG/Sqyr1GIr5j0c5Xxrjc7nEP7Jpvkq4xrkpkHhWQ8CoQHWa2
         ZtxZcWXwBPfSwi3T4zsLcVu9u3V3H/npQlVYAgfNh8vjtAgZdsljtMu5dR3EDX6tVa12
         190mibP+M9FBCO0l3uN7BYHOXNMSXrf4m0+L1omuv9eMtyxXUrkVeb0XHpEcK2gaWTrV
         2XQ+gV7QUQo156/4lvgY+dlGrUzmUomPck3jfHlhUbm+czK3vSSolu4sgFT4f4roqf5B
         yWdQ==
X-Gm-Message-State: AOAM530LqVKqDI8Sn8TUsW96ab/cJt33U5Y+WSP9+sOria5NpJu7V5Tu
        shjmiu/qMqIKFivk/WWif/Ukmg==
X-Google-Smtp-Source: ABdhPJwONy7CQ3+lzmfZHBf4GOW7ycRwqd8UaqFKCa7tofUgz7n4M6q65+GFFCWQpyC9xM0RpLPW+Q==
X-Received: by 2002:a2e:b16c:: with SMTP id a12mr6041241ljm.146.1595061869662;
        Sat, 18 Jul 2020 01:44:29 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42e3:6011:c93:75dd:e99a:5259? ([2a00:1fa0:42e3:6011:c93:75dd:e99a:5259])
        by smtp.gmail.com with ESMTPSA id h18sm2087863ljk.7.2020.07.18.01.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 01:44:28 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: loongson: Use DECLARE_PCI_FIXUP_EARLY for
 bridge_class_quirk()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1595061424-27701-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5a173967-098a-9e40-1373-5502506488f4@cogentembedded.com>
Date:   Sat, 18 Jul 2020 11:44:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595061424-27701-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2020 11:37, Tiezhu Yang wrote:

> According to the datasheet of Loongson LS7A bridge chip, the old version
> of Loongson LS7A PCIE port has a wrong value about PCI class which is
> 0x060000, the correct value should be 0x060400, this bug can be fixed by
> "dev->class = PCI_CLASS_BRIDGE_PCI << 8;" at the software level. As far
> as I know, the latest version of LS7A has already fixed the value at the
> hardware level.
> 
> In order to maintain downward compatibility, use DECLARE_PCI_FIXUP_EARLY
> instead of DECLARE_PCI_FIXUP_HEADER for bridge_class_quirk() to fix it as
> early as possible.
> 
> Otherwise, in the function pci_setup_device(), the related code about
> "dev->class" such as "class = dev->class >> 8;" and "dev->transparent
> = ((dev->class & 0xff) == 1);" maybe get wrong value due to without

    "Due to" not needed there.

> EARLY fixup.
> 
> Fixes: 1f58cca5cf2b ("PCI: Add Loongson PCI Controller support")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[...]

MBR, Sergei
