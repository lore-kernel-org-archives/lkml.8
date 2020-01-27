Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC39C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183FA2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="syNmAyoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgA0Ikn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:40:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40840 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgA0Ikn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:40:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00R8eRCo088203;
        Mon, 27 Jan 2020 02:40:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580114427;
        bh=xa0xzafvFH8SqiFAfVmhyJyrA8824lRN+gl7HwxGaOs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=syNmAyoPBOFuScGZ385BJZjO1IQHsGn8sNA2sgHvwgwaQUx3bMGmhlKuykMMmqbK9
         QRsy0LqbKdlMK4RScXWQ8nv41NyI+//WzPPXPYEAjTh1ihCHoXyIaTBXuKb1CaRDsC
         oWXx8Ngbn67wQTNP24QfipWAZP2s4Uy7QZkcZJHw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00R8eRrj063297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 02:40:27 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 02:40:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 02:40:27 -0600
Received: from [172.24.145.246] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00R8eNNL043988;
        Mon, 27 Jan 2020 02:40:25 -0600
Subject: Re: [PATCH 09/20] ARM: davinci: Drop unneeded select of TIMER_OF
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-9-geert+renesas@glider.be>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <be193d29-2787-d22c-1d65-6887a49bebbe@ti.com>
Date:   Mon, 27 Jan 2020 14:10:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200121103722.1781-9-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 4:07 PM, Geert Uytterhoeven wrote:
> Support for TI DaVinci SoCs depends on ARCH_MULTI_V5, and thus on
> ARCH_MULTIPLATFORM.
> As the latter selects TIMER_OF, there is no need for MACH_DA8XX_DT to
> select TIMER_OF.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
