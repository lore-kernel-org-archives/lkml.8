Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47469C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5E121927
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFNIhfeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgCKAeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:34:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40171 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgCKAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:34:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id y71so152176oia.7;
        Tue, 10 Mar 2020 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=eFNIhfeoptDPjhnSl7aIkO9c72byJlX5I60XHKlItxhdW7brmH2RnrCsKM1twJCsvV
         0We7+hO5zzQJDxJuhPQMLg0/U7w3OkO63B0AFltMULnNqztM9c8cG9GXPbUM5osiabwQ
         FV7OXhqIuUSRe+dL34SzfPgtTEiayJIQ25cPJxm6szeGSRifHynh9qFEWVaoO+Ax9NBE
         Ypvfm55ROc/HVBugA2JjJnUtlqdhhudeGOF3aS1W0g4swwOR7u2uqm/hczp0IXe9kYZe
         hgEpGtt/0Vu+SMqK4qSpOHTxj6smET6NcfvQ7T29eVKw4ER+kHCZSkOPLXo9+IDpsM3o
         AjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=Y10sJlocpwfBitJ1l393m5+xu2lKUIDd/UGqYFzCZwmrVERL9nvAOeNB1WxYl6RjR0
         ILsogEW80Tiu4H709tGm7p7TYYHm2I6EgqYCSSmh7E7o21ZPS+8CnjeaSEk0N3sLkcjK
         puUoO6kJN4NmT8yg2Yjz3VSNgLu+yrMweRQN/W9P6Yh69cPHYOPZdq6psVjiU4vQ5iPg
         jtcU9ia4nx6X7o5RrdCkmEmpn5u68usJz4sY2gcaI294yaZTQsNucxAXt5ySrZ4LYNBr
         AKxzMecX4rMLUkfkfwsN0WRVPLghQFoDLKmswsHLM905tLEiSemqr/Z3KO2Iz+BDt5iG
         RRPA==
X-Gm-Message-State: ANhLgQ0pFD8ia9IwhDD/soXJBZoRNerNMzwo21o/xy2CNGFeuugJWu3j
        nYiizgkEwiF6zOBX9RWoriDddxihcMGEiUs2FA4=
X-Google-Smtp-Source: ADFU+vuOazbtlfW94m5+M4j8b/midKi1ofHML9KC8bcTuCp7Op5Pcv2oPA/ySHc9B1r/KUiYUmQLjRL2cpksMd8VUeY=
X-Received: by 2002:aca:1011:: with SMTP id 17mr246182oiq.72.1583886839856;
 Tue, 10 Mar 2020 17:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000490abd05a05fa060@google.com>
In-Reply-To: <000000000000490abd05a05fa060@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 10 Mar 2020 17:33:48 -0700
Message-ID: <CAM_iQpVrasivmeLHfxFpBcTxYr+Er-KCOrdSR0L4Bd7DuzxHhw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in tcindex_set_parms
To:     syzbot <syzbot+c72da7b9ed57cde6fca2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/congwang/linux.git tcindex
