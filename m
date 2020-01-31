Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D936BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C621734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1renAzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAaUwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:52:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaUwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so9437195wmh.3;
        Fri, 31 Jan 2020 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R5oL7JnUJ4rA+4yVZSrfidjw5dQDI8iT/dmqiYUNC7g=;
        b=u1renAzXuL52aAj6gfz1+yvKnTTajawMR0qOjwsOoB5Jkt1h4ghEMoWoIg0mrPcyPY
         6j5a6HB1pdh5lQcPERKtnbse6OSnBS/rbTAsH1iSzJR399GBxLmXjWnsNmmE2TpqgH6u
         CzDuY/fhpAFyXkenj5/bIjQjPe/zYNujRb5R0jA7dCi40ksbjzq4bXG2pW/CKHlKDBqO
         DeuAZcPKHtz69uWzOG94SjQp+e1HwxMz7eDhXGx9nhr3A0f3vwteZ2aWt2xrUGdDZsX4
         mx5as5sJEbhtpwZZZRQrgybYUVrm69GeFucmlgHcVdq7nx8vicEqKobc6PnL6USqmyQ5
         X6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R5oL7JnUJ4rA+4yVZSrfidjw5dQDI8iT/dmqiYUNC7g=;
        b=dbaoo5v5nZzUGJCPdGgoRo69T+DYlMATofjMCf1ZG45UTRIIRAzLlo7MZzjBuvT6An
         wm2/6DXI1pCfWS32usjTMF0wKTMues/fNSViv198aXJIKswwlXqxZ6nhJXUXQRFft2sl
         s6l/q1BhEic6QnEBHHTViFdwyHAI04vhFLNgzYGT08f+bTYNMLiZUM5A3XaNOHnyoQUa
         XSr9KY0VaRE6xMHresB1+K9sLw8HW6V+iy9M9oT4QgQuTafqvxwVlsjSbVT8Ihgc/dNC
         /WfA2Jk+93zQGgVTKJHVjA/g52QfyqxX3zvJHNro3BiS/1xKTjD2jSDGaG0814OQYJIo
         z8Ng==
X-Gm-Message-State: APjAAAXJxEhvIxy4sqVV+fSqW+ChUD6T4jY6gNZrr1TtOvFIdz9DTtFN
        g2B1wXopfKivGpF+fGyyD4Q=
X-Google-Smtp-Source: APXvYqykDKpY0GM3JcAlPa+jlXGJKkR7bIke/R8VoOEb1wYl4kAIoA6TwaQcJUF8G25VoSsXRD5+nw==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr14691239wmk.128.1580503971337;
        Fri, 31 Jan 2020 12:52:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bcd7:b36c:40fc:d163])
        by smtp.gmail.com with ESMTPSA id z3sm13483738wrs.94.2020.01.31.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:52:50 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Documentation: Fix trivial nits
Date:   Fri, 31 Jan 2020 21:52:32 +0100
Message-Id: <20200131205237.29535-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset fixes trivial nits in the documentations.

SeongJae Park (5):
  docs/locking: Fix outdated section names
  docs/ko_KR/howto: Insert missing dots
  Documentation/ko_KR/howto: Update broken web addresses
  Documentation/ko_KR/howto: Update a broken link
  Documentation/memory-barriers: Fix typos

 Documentation/locking/spinlocks.rst        |  4 ++--
 Documentation/memory-barriers.txt          |  8 ++++----
 Documentation/translations/ko_KR/howto.rst | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.17.1

