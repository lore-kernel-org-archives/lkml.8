Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE3C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1E42051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBEJLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:11:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:42326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgBEJLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:11:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BDA66AF27;
        Wed,  5 Feb 2020 09:11:28 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:11:26 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinglu Yang <yangyinglu@loongson.cn>
Subject: Re: [PATCH v2,RESEND] MIPS: Scan the DMI system information
Message-ID: <20200205101126.4fad0946@endymion>
In-Reply-To: <17537451580871338@vla4-87a00c2d2b1b.qloud-c.yandex.net>
References: <1579181165-2493-1-git-send-email-yangtiezhu@loongson.cn>
        <a267161f-c8b3-a11c-7416-3ab9ba19aa82@loongson.cn>
        <20200203131422.384cd168@endymion>
        <609c7042-0e44-2bd4-5e03-97465621b184@loongson.cn>
        <17537451580871338@vla4-87a00c2d2b1b.qloud-c.yandex.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Feb 2020 10:55:38 +0800, Jiaxun Yang wrote:
> > I think it is better to split it into the following two patches?
> > [PATCH v3 1/2] firmware: dmi: Add macro SMBIOS_ENTRY_POINT_SCAN_START
> > [PATCH v3 2/2] MIPS: Add support for Desktop Management Interface (DMI)  
> 
> That way will break bisect.

Are you sure? As far as I can see, each patch builds individually. The
dmi patch is a no-op alone. The mips patch will not work alone,
obviously, however according to Tiezhu dmi_scan_machine() will fail
with a harmless error message if the base address is 0xF0000. If that's
correct then it's not breaking bisect.

-- 
Jean Delvare
SUSE L3 Support
