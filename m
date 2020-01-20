Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E16EC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E374C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSpo2JIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgATId4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:33:56 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44019 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:33:55 -0500
Received: by mail-lf1-f48.google.com with SMTP id 9so23366068lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uO42+sI5N9FmSgljhuBU9giGkvtQ85lUIK0eQqdqVIk=;
        b=QSpo2JIsEdTJtApIyfNFT5QiinCi4JRLhAED6CvwPFe/XAu0ulzrINeP3SQyufOOQq
         2zGPW21uwfgc1ZOBBwQKHDSakz2xTYyTqXgifO0BM95lmqMU5surU3rOgYXZdk+1+0wb
         KlqbpiQD89DLWbvIz8TwBrU54VxnwJ6S1FFxfeS75ZJ9GM0G1eB3r9jd8MvHtCAahvpN
         ODzOdwiWGRqSPm6v6D+auhCmUdrnDe6pT1igDsfU0FWCfqwSCocRLt5LnQf2DuBhclNS
         YDHiSVfKzGxGlOiZH5wx3AYMELVSB2aETzXiNP/AWnilOPD6oWGR7IF/QLKPB4qv9ac+
         A7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uO42+sI5N9FmSgljhuBU9giGkvtQ85lUIK0eQqdqVIk=;
        b=fCDeOHYCPFm5aA+xq05fzCl33dlrFBOcaq3x3ZTD5/BEf/Kh72Y6LVvzxmR4IxJnwE
         YTWSkzXdDeOnRPrZPUz39rJ8dZYVu7jO3kqKUAyZD+VeFQlfJNwGGuEQRW87LrufEQvW
         X8dINY881oZdNYPBDgv95jBPbLsGy6jJzSepyksTxdKu3RJCixoOmr/En3FdQDsB1UdO
         0tBZsUUmRQjLU2iacd1E8LakCY24nqylwnkQg/1axHy6beoosBMwMEKkuAZdfmde6Qef
         iG93CL1kCfDock0Dc2shN27tcDqoqZJ9NZaqZRLky0UofEwHsX2IZmdSFx8RdJVC8xV+
         GNJQ==
X-Gm-Message-State: APjAAAXrxDZvP3Xww+OesAusDFVt0Us7zCq4fSGrBIL1b0reGDgyXL7k
        TO2xjd34YYWFNE9C/ZyOwrzh8SXRqtctX7ex7T0=
X-Google-Smtp-Source: APXvYqwzI9R02ueNHRAdby6HatQG4aq1Yn7p4Ej+rwGMo2bd4QxJSp6Cpa0Tdis38YjTSqpRMlUwptL/o7kwk6UBdQE=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr12683865lfn.137.1579509233767;
 Mon, 20 Jan 2020 00:33:53 -0800 (PST)
MIME-Version: 1.0
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 20 Jan 2020 16:33:42 +0800
Message-ID: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
Subject: Question about dynamic minor number of misc device
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

I see there are 64 free slots(0-63) used for misc devices with dynamic
minor number. But PSMOUSE_MINOR(1) overlaps with that dynamic range.

So if the dynamic minor number exhaust, psaux driver will fail with
"could not register psaux device, error: -16", is this expected?
Should we preserve a slot for psaux and serio_raw which use static
minor number PSMOUSE_MINOR?

Thanks
Zhenzhong
