Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF20C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81C420768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgSqKNJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgFZHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:10:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2409C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:10:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy7so6108700edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qpZpuiya5CROhmtNObER2gnYx/Sa3Svm9oWXZ7DP6Qk=;
        b=jgSqKNJDsf8B1b0WX1oxZ+L2v9c22xYY2gJ1DEQDwj1e438xUkK5yPpdXYHD/XEuKh
         7r3WHewZl3ENYtsXVa1ZSShy6ifTZCnNDmNCE+KcY2gDtQs+uSGVEkK8V257JfE5+xzK
         PXWb0ktWxx5S5hSrXj4VwZKq8csTAkQ4PpN0rt5cQrfX/caY4xVuOFcqydQDX+x5nJ3i
         WKbpaX/akV9t52JCGpPn9AP/9rI9LTi7Y8CM4rOsWX+pgR4PJPaigMTCigeqBRQNSmkq
         KjiI6S6HFGXUYJfallyX3JXAKfbnfvvO6ygMOROsFuFKva8uYJGjv6sufx7wVejnrDQD
         tV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qpZpuiya5CROhmtNObER2gnYx/Sa3Svm9oWXZ7DP6Qk=;
        b=I/HngMK6GdHpeLjr5zF5wV/kIpLHZ+ucA2t33c39EgMoXgIXLMygAgMUx9NiTsejXa
         jmzYbaYZSs9HMCc7HUYU7ezdJbzkp14BwaHR4e8tM1mCI95buIRwl0h2YoNIgJfJF+eA
         JrbKzpRuNCUud5qGEs8rsgho5c//lSn2+pAIheYMB4Xj7b/KgjpxE8qv03s4mj28ycHe
         0kF8MiRcCr2MJd4+IA/YaxTyz+v1RfG3crNQ15StKd+Vi/eLQFnnjx9FNH4DDdil0ZqE
         oXa0Wr144LMQk68hKq/yBEYd64X9wkazmO+xcepPVCFW9ZueSxXdUe5KhQPV5SnUQyQ7
         kPUQ==
X-Gm-Message-State: AOAM533xUiPlmM6my5A9tTd++goQb9PdDBq0XyLimXZpR60gtvljRj+W
        MKyHlHVhqBsFe3qAe+YIt36Ya0bpCBMPCSE2WVHaHW0gbLah
X-Google-Smtp-Source: ABdhPJzaENxoEuSgSLC1vX/6lIib4fLfF3GFQu1g6qti9Z5Q79ZuyXMJGBviyhwtp5ej5Wbi1Flv9TL3ks8LNMEiO4c=
X-Received: by 2002:aa7:d7d0:: with SMTP id e16mr1357037eds.10.1593155422168;
 Fri, 26 Jun 2020 00:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   Mahmood Naderan <mahmood.nt@gmail.com>
Date:   Fri, 26 Jun 2020 11:40:10 +0430
Message-ID: <CADa2P2W=tiDrZ1Uj2zgs1npywHtvQiv_1KFzB-EbN5gG4tCHpg@mail.gmail.com>
Subject: Question regarding brstack
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I used "brstack" in the perf command and see the following entries

0xffffffffb220bda7/0xffffffffb2209890/P/-/-/0
0x40053a/0x400530/P/-/-/0

The first and seconds are said to be the branch instruction
and target addresses.

However, it is not written in the manual if that is a virtual or
physical address?
Any explanation for this?

Regards,
Mahmood
