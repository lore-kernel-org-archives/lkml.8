Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7BC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6359420716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xYgKvx61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCLOHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:07:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41607 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:07:15 -0400
Received: by mail-io1-f65.google.com with SMTP id m25so5775075ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oCQZrJERoMLVJX5x1RC4/10D7o7Of6OtemKn4HOrLdo=;
        b=xYgKvx61D4K49Vvkz8w1kRkqt+NeOXWdiLUS1MBdwmJxvRzERDXCuph6yDN4el87a7
         LwKf4V4k2gjhHiqLtE3Ei2sAqnRrW8nuRpZWfzqrMrToy8FOe6FE45ghOG0kyLxQJFJi
         Dp5viiCX/mPV+Kbtx+gkoNohSerKHKasipXZ/JNB4t8GP1XR2EhZwIIGhHs9Ti1jcRl5
         6VpzNL9+idY3vxZGg/K/H/qTlcNnMGpDccW1I1pUD7h9/wwVQUJTQNrmIQBNPkO1Yv1E
         +4U6vJhcUKN5IYEx8ZLCqIUp7Rb+Jr4ignKtRV473wjYuaLZRzSguZd8Q32OHC8FsMco
         Mx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCQZrJERoMLVJX5x1RC4/10D7o7Of6OtemKn4HOrLdo=;
        b=JYauAa7vq6yrEsmx1tTs0JgprLs7oL4VP7aV+5izc+YB/kKJmiOaEv+wjNjq55ZXhD
         NF4WrvcPrdQ5eF2QT9Ego5udyCt1F3Bc76NFu7q6eN/6jPkzutq5dIIqYmtDhykpSdbg
         xsNqpnRAFNPjw9klqaY2w8PzyEsrQJQt1C9dftvyWN1h8rYe2HzFU2No9p7g2LKNF1ef
         aGtPpO0DXGdGErdPztm1+V/ECfT360wrmxlNuZZDh5mn+1tYnnfRCaYdHCKhDDboDqXy
         er3arHOD5xhSILr2fm3r+DKR1n50fSDoSnsO6nr+yY1E65p4BasqUBG7N3f/i7O62D9M
         KvDw==
X-Gm-Message-State: ANhLgQ0roBibC/3pHaKH5GeVl6ScLY9SEMdlvb6o5woU31tMUyktGocw
        aFE+VBtPKEfqEi94M8JKymWYRgmPge+NkA==
X-Google-Smtp-Source: ADFU+vsD36ki6VGiTjq4LiW76CyWNgNwT3q+tOD2iHOtZOyEJTeKdsK1gWHmB2n7L38BS0zcPcRsdA==
X-Received: by 2002:a5d:9b12:: with SMTP id y18mr7789355ion.176.1584022032775;
        Thu, 12 Mar 2020 07:07:12 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 4sm6131345ill.46.2020.03.12.07.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:07:10 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake H RAID PCI ID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200227122822.14059-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d7f9e0b-7410-1642-cc63-ef6fcda93540@kernel.dk>
Date:   Thu, 12 Mar 2020 08:07:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227122822.14059-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 5:28 AM, Kai-Heng Feng wrote:
> Add the PCI ID to the driver list to support this new device.

Applied for 5.7, thanks.

-- 
Jens Axboe

