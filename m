Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D161C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F2206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaBEkfy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCMR6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:58:22 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46392 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgCMR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:58:21 -0400
Received: by mail-oi1-f179.google.com with SMTP id a22so10291729oid.13;
        Fri, 13 Mar 2020 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=BaBEkfy9fSg5rAPCDiqzZIiELJ/PLQHGkPtDQpn+YgnUIo2R3/+fOwxlQnOLXLI/DH
         lABVF4CRyk2NU3/1/nH7P/nwwkTe+vIkxz5VSMIMCwvO3Nm6+mlIQdVzvsZlZnVMPoT/
         RSwWcX2xWngix4JiTZ5zbDGiWGAoO/N3DlCJ/dAC1c7NfvYpFw68H5B3q1HMEgp7IJWv
         CtQAYGzyiXq9+KTYKPZIrG3deZY9VWc8dYGYlmI4tgmZJ7gA0jlk4K2SgideUsoqTbTK
         hjyJ3HUhCflQvlB69PpHVWw/aAI6A96PUdHds64wnq2PZ0ha8G+u1lqWb1CYg6o9c7zT
         AnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=m/3Q1PN3z9ww5aBheUpuF9cCPsaQytqySjp3mb7Ua9nPatp4CT9XNASZFhcQ4CeeSN
         s1kL2D30+Vt/b2dWCLVtZum8433fOVrZ+nz1VpFKv+K4ni8bridczEfCqFaKYq3EVA4l
         K17zqxgmqCvOthQv+Jovy3UBnI3QRlgn5i3mUNHGmCZZiyWS8GDvLfsWJUoLg397mkg7
         hNbvuwJUCVBSiBstItUnXF7UeFlxL5sqvLg+GtBUaY2JXpewjA6acZ33qmOo/9fUofPl
         RKmOAuRRAWSqQAlGn8vSReQ9qCQT6NzxTISUZi+rs7QS7NewerxQBpqivq9hRnsfmniw
         wUiA==
X-Gm-Message-State: ANhLgQ1lQfvrh3Xpma8I96ikIGTr8t23adXGHKpyubfCZkcujTMhn/Ku
        9Mm9Q40OJ863+50pJanE39BYLLp6Cw96Q/givFT5nbWz/mQ=
X-Google-Smtp-Source: ADFU+vuyaFnlHIOZ7UMMpLTRA1bOyehewTVIvaDe7GW/6wQdEvRxU8L9GFdKFFtWY/jqRHNOpSE9WFNLlGb76Lt62ek=
X-Received: by 2002:aca:ecd0:: with SMTP id k199mr8164348oih.60.1584122299626;
 Fri, 13 Mar 2020 10:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b3cfc805a0824881@google.com>
In-Reply-To: <000000000000b3cfc805a0824881@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 13 Mar 2020 10:58:08 -0700
Message-ID: <CAM_iQpXM7daXmcEGjk+CuOFf3KDixDidWSDpUAk=RcpRehF+Ag@mail.gmail.com>
Subject: Re: WARNING in call_rcu
To:     syzbot <syzbot+2f8c233f131943d6056d@syzkaller.appspotmail.com>
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
