Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA220757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 11:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeViB5Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgIELij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgIELiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 07:38:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E475C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 04:38:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so8399485edl.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=73YIL5hC/5FKK76aTl+EZhGYG2VJJsNNuC5JtnlYs9k=;
        b=AeViB5QdEEQgHCNl0e6PWPlFsup+uh6W4Iv6cNuy+IKdv3b0/ZJ4cubn0+R7gitq+Z
         C3BGg5aTvq0HhlashKmitrgji9wJJvgBcmYKTXhHl/g5obaAp3iUkYq7MxTzvhkXEInJ
         klR1e71gNeUxDgev6qGq61MH0iQ7gK1wIz9swxIJ6UuoOADOj+bg5HAxMksW3csg6x36
         +LYI5xvxqYHPOi20PA6ll/QBAsKVr5aWbe5SKGt7biAW2J4Z8z7ac3gi5EOJYOblWHam
         Ehpn9o3pidXTy4dnZ9W/HOL7yGsqGyhqiC8rGlQe/uFYPmfYYdS52Or40QBkjGoJKpk6
         MtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=73YIL5hC/5FKK76aTl+EZhGYG2VJJsNNuC5JtnlYs9k=;
        b=Wrx5wR4dhRKik/HMuINOON83uWPAZdRHdiPSg1/NQw/o8M0KOl57p03Co5o8Xmg/fn
         rvkukhtPto91qijWItQXpD8cjwND4udPGVIitjKxpoXN/VmYN7/QHT2epawPlxSt81XH
         YwbGmVrbrIov7kPY3tIhma7pyqSTl0sB7wX9bgBdGK7SwhpD7PM62k0mg/ofS2+P+3B6
         AKrfQTOXpPr6SVTbVMbHPds78Nm6sV+MOfj6MCkZR3jjSlz1XEUKb73Axa775eo5K5ob
         ilNMfelZKsArKwySEpWOfiznthKJfe41sfDE58p5apPp/Zm9bZ7jgK2xEJDgvXVsXk2Q
         MoTw==
X-Gm-Message-State: AOAM531v68iawDpPe5KQ+u1PJQ2HZSANYfZp+UfJSojA2kqqsR0LVnQZ
        nKc8rLU7XlR1v+eREIS54g/rRmvL4wo=
X-Google-Smtp-Source: ABdhPJzEHNZKGKwbNkFJNfmIhj1BRbKd6T7+LzysjnsuFXZj/3eul9WjMeY1KhF6PLppYi4uImFnYA==
X-Received: by 2002:aa7:d88a:: with SMTP id u10mr2090669edq.217.1599305885778;
        Sat, 05 Sep 2020 04:38:05 -0700 (PDT)
Received: from gmail.com ([46.101.156.237])
        by smtp.gmail.com with ESMTPSA id w20sm8733624ejc.77.2020.09.05.04.38.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Sep 2020 04:38:05 -0700 (PDT)
Date:   Sat, 5 Sep 2020 13:37:52 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.9-rc4
Message-ID: <20200905113752.GA4762@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this trivial change to auxdisplay.

Cheers,
Miguel

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc4

for you to fetch changes up to 46d4a403a04c0ba46641452367b6a04bcf918a06:

  auxdisplay: Replace HTTP links with HTTPS ones (2020-08-08 16:10:03 +0200)

----------------------------------------------------------------
A trivial patch for auxdisplay:

- Replace HTTP links with HTTPS ones (Alexander A. Klimov)

----------------------------------------------------------------
Alexander A. Klimov (1):
      auxdisplay: Replace HTTP links with HTTPS ones

 drivers/auxdisplay/arm-charlcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
