Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D862C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7368220768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz31ZnkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgFZHGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:06:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:06:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i18so7596738ilk.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MtKclr9OdZMSb7vCn+NrvbF5zVlkKXs3UwV6lq9Pllc=;
        b=sz31ZnkQqHrDk+t90kSs282SEx6/BsWRtw4OXLqsdlVQbjfNGKJYXuzWbWx8HVvXG2
         7T3/dR9Ad8adcl8FpXEegmiSM0VgrHgs2/f0I9ZdN9Y93XYYLQdl/sIKrlv1T4yKXAz6
         hZP8iR7EW3QUTbc6aEMVK3TjjzHmptQJObTAb2WOh8O6xKEXUgWcFaLWXb27i+u4fZ0I
         sk/ejf9Jto7fKHSGZUwkh1qyg+5Rl9BlsdQ59EIgaLXCcVzB6ZtjH0KHqhzTJ2m7tyQb
         GRD/3LfX5mP2RDU9pLYV04ldiQQkoSVfuVpesTxHmWMlhZxXJy0tqLy3rstgIm+GdYPX
         ozrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MtKclr9OdZMSb7vCn+NrvbF5zVlkKXs3UwV6lq9Pllc=;
        b=G2T5YT7EKJXXoytwtP+hRH6npXTgg0WQfJlRhUk8XQjwAlgoP+d+PZ1OTibn+p6vYa
         IvTGjMBoNRn8HIvM6d5B2ECicbpCa2Yyf9E0vZIXmX3m8i+NWUqzprN3vUmKQtZ+FiNI
         noWf8aWjLdiujQ/8lgtzfsaA9UqjpsbZZSW/gdkfZr7QLjVIwfjn6FUcNmJ8pf/88nSb
         TWyyyZaGNq+tfYh7ANDnJVEYwG8w/7DS1G9r4Emnwt+jHDy19wru8BaGzNoIATyR4o8X
         xi5mb4CBeYfNZmqNNPROBYkx+OoywPjroRJ4IFyOSPvvmohVkwDmS3QjbtNmKgfwRURN
         vUJA==
X-Gm-Message-State: AOAM533fcgW35NPMG/w/qM8Bupmj53v/t0mo80lhggpBF3RHwFolTXsn
        xzjc236rXNtOMbxdubJER4+nPwA1LAUtRk2EKQM+5yBytAI=
X-Google-Smtp-Source: ABdhPJxqdoFpRnQ4vFIE2qr4eGttTp0b6xNYWTl5OI199FAu+7Gy8UVATo4F6AZiFXGyK04i6HaK9CLyUv4K5YPawzk=
X-Received: by 2002:a92:849c:: with SMTP id y28mr1592981ilk.33.1593155190489;
 Fri, 26 Jun 2020 00:06:30 -0700 (PDT)
MIME-Version: 1.0
From:   Simone Magnani <simonemagnani.96@gmail.com>
Date:   Fri, 26 Jun 2020 09:06:19 +0200
Message-ID: <CAP5XGZeuaHyszy+j_NzGmMW8AzwGSvA38HjFp1VU1WV59QzC-A@mail.gmail.com>
Subject: [LINUX-KERNEL] - bpf batch support for queue/stack
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm Simone and I'm new to this community.
Lately, I've been working on in-kernel traffic analysis with eBPF and
the newest features released in the latest kernel versions
(queue/stack, batch operations,...).
For some reason, I couldn't help but notice that Queues and Stacks bpf
map types don't support batch operations at all, and I was wondering
why. Is there any reason why this decision has been made or it is just
temporary and you are planning to implement it later on?

Reference file: linux/kernel/bpf/queue_stack_maps.c (and all the
others belonging to the same directory)

Thanks in advance,

Regards,
Simone
