Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A3FC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812AA206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dd8OSsE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBWQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:53:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgBWQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 11:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582476806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=/e6mKMfpKSy3gdVdlHZUYmc7ZeUH2nePA31LvFPzezg=;
        b=dd8OSsE6FkTp9YtqqMGutgOFHT8EFZiaaqWcdgab19ax0GUapJCp2p0dMTFlKcuBvb9G/p
        UvzOLiQrVOejrGwpjlo/PMh1/rYEHi1qbjOZL5jJuXd8+aGI7PddGcRWBZTWYHN9pN+7+4
        HNuZPMbPFZ4j8eAHgbNLr5qDttQUWi0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-8oeqmOaDP0mZ9oEv0QN3MQ-1; Sun, 23 Feb 2020 11:53:24 -0500
X-MC-Unique: 8oeqmOaDP0mZ9oEv0QN3MQ-1
Received: by mail-ed1-f69.google.com with SMTP id ay24so5128575edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 08:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/e6mKMfpKSy3gdVdlHZUYmc7ZeUH2nePA31LvFPzezg=;
        b=iAlfC0AbdwMrBJBR18Wo+NcgJfV07RMo4tby3xcIO7jZSUC2GchS6w41alpAsELZR3
         AqgswlrTJT64kYSDSdKAB0n6/6svSElljc6+FZVHgMdVqkj3HKmME/pwULq/t7isTJ/5
         8HYklZWeTRTJ5Cp8Nxa2XBmQptrs1ffUN9nGe+lv4vWwU+oUu90RH7VouMLvAuXgMehu
         3YFlZPA8TR51QEXmBIR52MvdXf67ZZBcnvpv40pghI22wAKTrfy8G7rpDi958y1J4ktW
         kgvqdhpl76cV36QI6coRAAnPypT1GnPPiv9MDH6XYAFdxXTeBzBN5LKVMu0G4cZtPfrr
         ZLYQ==
X-Gm-Message-State: APjAAAWc4yW7KJDosuau+lD4T7qN7ZW/s9rwgqd8SSiGfnNsoK+/LorD
        PVzjmLs6hHFhQmECghYCbbq0zENRU2rrwWbOhzicMQmyoPapRrVGO9oXoG1GRtDtraXGcCftiyi
        AxhTfwCjlEn7pBgPY8ZBSqf/gxgPPVwOQ0PMi6De7
X-Received: by 2002:a17:906:af99:: with SMTP id mj25mr41968263ejb.293.1582476803282;
        Sun, 23 Feb 2020 08:53:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWJ9K1R5sSW2X5rEJRiM2cWz7UXXYiLOljT9yzR7BnnMCDxY+qhaJvp9AAf88p3dKdNXEDi/1cWynDPk3DZ0w=
X-Received: by 2002:a17:906:af99:: with SMTP id mj25mr41968244ejb.293.1582476803040;
 Sun, 23 Feb 2020 08:53:23 -0800 (PST)
MIME-Version: 1.0
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sun, 23 Feb 2020 17:52:47 +0100
Message-ID: <CAGnkfhy6w4TT=vm9o+USHLHuKpr_fzgbSXaK3JkEKhvgYFQrAQ@mail.gmail.com>
Subject: typo in MAINTAINERS?
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRVIER vs DRIVER?

ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
M:      Minchan Kim <minchan@kernel.org>
M:      Nitin Gupta <ngupta@vflare.org>

Regards,
-- 
Matteo Croce
per aspera ad upstream

