Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01558C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4A2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moreofthesa.me.uk header.i=@moreofthesa.me.uk header.b="RRDWFtiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgAPVWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:22:09 -0500
Received: from moreofthesa.me.uk ([178.238.159.109]:54642 "EHLO
        spam.moreofthesa.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAPVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:22:09 -0500
X-Greylist: delayed 1087 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 16:22:08 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moreofthesa.me.uk; s=201708; h=In-Reply-To:Message-ID:Subject:Cc:To:From:
        Date:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0ordMptwqL+7MqYAIKv1O1Ieb3eNxf4cNX632cV3+dI=; b=RRDWFtivoFmKXXDB0m7aeAH97d
        D5g/kj9Jnkk6taQz/jfaaxvQyIfIxxD6+/ycumnS2Ydc+8/enlTDDoaEWr6sn01LVdVvc2VVjU/B/
        rZF6MNXbizAXZOmTdjNvtZ6xAo35wme4ZJYCgn7YaYzcpcPb3eqnNu6xvzDvLiet+n4Y8twAi3RSR
        xiECOcwi0OdpTNY6r90HRj04PcZCHH86nRlxeH042Jiq6pYcUoJMBzi617tmybqpa72qxRS6ua6Ch
        EXAUya72hS2nmyLQCjEUyzlg2WLaIM06dNYyILbzgxppyhFHVgtRvOwERvxvSruBfT0Qxee6C/9IX
        ZlSZqsEw==;
Received: from [2001:8b0:897:1650::2] (helo=moreofthesa.me.uk)
        by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
        (envelope-from <devspam@moreofthesa.me.uk>)
        id 1isCIx-0007Lo-QE; Thu, 16 Jan 2020 21:03:57 +0000
Date:   Thu, 16 Jan 2020 20:55:16 +0000
From:   Darren Salt <devspam@moreofthesa.me.uk>
To:     linux@roeck-us.net
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Message-ID: <5838D7FEC0%devspam@moreofthesa.me.uk>
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
Mail-Followup-To: linux@roeck-us.net, clemens@ladisch.de, jdelvare@suse.com, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Darren Salt 
 <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Thu, 12830 Dec 1984 20:55:16 +0000
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-By: Darren Salt <devspam@moreofthesa.me.uk>

Linux 5.4.12, Ryzen 5 1600. Patches were applied cleanly. No problems noticed in

    $ sensors k10temp-pci-00c3
    k10temp-pci-00c3
    Adapter: PCI adapter
    Vcore:	  +1.11 V
    Vsoc:	  +0.94 V
    Tdie:	  +42.8°C  (high = +70.0°C)
    Tctl:         +42.8°C
    Icore:       +15.59 A
    Isoc:    	 +12.63 A
    
    $

-- 
|  _  | Darren Salt, using Debian GNU/Linux (and Android)
| ( ) |
|  X  | ASCII Ribbon campaign against HTML e-mail
| / \ |
