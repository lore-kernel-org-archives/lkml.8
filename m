Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65AC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD09C2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="auyatp5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgBDWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:31:51 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:35623 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:31:51 -0500
Received: by mail-qk1-f174.google.com with SMTP id q15so19783574qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=MGVGB2Yy9x4+QsZMk3BaiFAAfgnqpri3gvi7Vh3Ozkk=;
        b=auyatp5jP6/4Z+MEJpp8p4b8r3/aC+EWelvmhPMWDJKkBXkVaWMapZL2y/liZ5olOv
         ho0DAb+/A/s6TuGvsZxxqkg9o8OaSD09MZZ/CJNVuqWgLzLO0EoiSfgBRx6T8AkThzEN
         9t3y90F9w62BvrMVB8usjyfdDPT3i3Y+YKEnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MGVGB2Yy9x4+QsZMk3BaiFAAfgnqpri3gvi7Vh3Ozkk=;
        b=BJqCqEGwL5z23Dxw5Q7xycbbJJvExSjlgMe/rQN+gZAu04OT481OT8EaEyWCw0r4W6
         6tG714wnAo7qQ8ooHRDnlYz8xGhuMDfdua4hr0TmiDlJloXC4yusVpP4SLZlQnQCwr+H
         N0qJr5V+BoDXWguwambD2v3RyQbJbKrAO6jBcKU5fONdaoswWOwvP+6qHcK9ISOeuAak
         Uf9DuvOp62L48qffOUS+c3mtaE/BybElpcVHsBHbf0DL7AJDy4RbMQjMHsf/MiI20ggV
         k2chgOisrRTfQICtIF9q/h/RW+bqWd8tyzG2ya+yXTadafF86WOzcCEYU5bDSY1DXTfb
         lyfg==
X-Gm-Message-State: APjAAAXm+0fC2B+HWe2x/lhTwv4aHI4FBl+i4b8GKMIvvuWcZP8dy6ap
        dhXVoftanvoOHdiBQ551GoO+wRykUi7bC2jOJyPYe1Qt2gk=
X-Google-Smtp-Source: APXvYqwBoywevZOECFpmhWNBuJJe7BfGTIGpYW3emnpxmqpzT9OMLWwzrKEhkaO/ErccoEAPdG3StIxChqg8Rp6/20s=
X-Received: by 2002:ae9:c317:: with SMTP id n23mr30663121qkg.356.1580855510123;
 Tue, 04 Feb 2020 14:31:50 -0800 (PST)
MIME-Version: 1.0
From:   Watson Ladd <watson@cloudflare.com>
Date:   Tue, 4 Feb 2020 14:31:39 -0800
Message-ID: <CAN2QdAFiLAwsBdPAmR6K3kg3jzZ-ek2oESe1UnVrbjUvGfd2MQ@mail.gmail.com>
Subject: Additional interface to kernel timekeeping for leapsecond clarity
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm writing because I'm interested in adding a system call to linux
and other free operating systems that will return the current time in
a structure that will include a flag for whether or not there is a
leap second when the result is taken. While adjtimex exists, it's a
very heavy interface to this functionality. This is necessary for
computing the Modified Julian Day+microseconds since midnight in
userspace, something of interest for roughtime.

ntp_gettimex doesn't quite do this either: the TAI offset doesn't let
one compute the Modified Julian day without an almanac. To the best of
my knowledge this doesn't exist yet, but I would be happy to be proven
wrong.

Adding this would make it possible to adapt userspace to the harsh
realities of UTC.

Sincerely,
Watson Ladd
