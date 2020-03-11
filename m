Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFEC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0720727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw7PTvl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCKBRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:17:52 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44369 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgCKBRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:17:52 -0400
Received: by mail-ot1-f45.google.com with SMTP id v22so253542otq.11;
        Tue, 10 Mar 2020 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=fw7PTvl2MhJgDakZwvudlq0gxJTnOwVNwCEqEat2rdtdkKmeZD8+70LgewQKpboECD
         Nb3SzqyR78fI5pUOaB/tt0hV5wxYQMqNdPwdQkfksMMg+mFNDPoI6dkjnztOyrwyOZob
         CksHAs3+/gubF1CrA0ec6vzlANwGXOcI0F3vuk0ONUu5dxjN5UsQsUUDJU94B90k1O/s
         SeuH+FQ0eji2Pacvqzg57mMmyh7a7TEmh074TZrbH0H4q3uQ1bO275Gp0HP7+SRwCKM/
         5Vbifz3Lerhj5zs/dWMTpYTiyt5HQKNzn9m388XDl6JjcGXcdfZAuFUaGtiuhzOkuckm
         k68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIpHicZ3t9iIlvAbQDoq7yMgDqITyaH5TIJrz/BqXnM=;
        b=mfGjEAItK9JUpwbWEZTnpDv+Qo46mF+Z0xuaA5/kYTy1LknYurSH1Qf2EHWu2za1q1
         cVgQo4iaHzTbvOKAXVu4QfafOdq4J6ocfe05MwulwzzHRmoPRhsf/bVqR1h3v0nQK75L
         2tadnNw8oGRdMaVwjBIUDdqIXm5TMR34BRc0XXSKj7gTNbeMvGa/T2RjT8LcdmJ3nir/
         4HlpMNPsoFHGVbeHBcVg9U5fpUOPemoxjmwJpsQQn9OWfk8Y0G2HamE/EOtEhljgshMw
         oovdOvTZ4cB2S265wVd0F0RVFVHq1dB+WE0mUdVVglMiwkMy+BDvv09KNHOAFlCQpPGb
         AWaA==
X-Gm-Message-State: ANhLgQ2ciUBkmHIO5EpItiAGTTBt4gTo9Z3OnHWDnnH8i+6ofliSvkVp
        ACTzMXPPmg/8Iud3Tmhexe7g4N1+DFhFWGfjZJs=
X-Google-Smtp-Source: ADFU+vuhKF1v+vup0kdBVr7A8Vm7Jra+CtZeQ0Wyajafk/bF5zFsN/TFEXuiVxHKa+W73xkLdUkBFs8rj6nK6NrpE34=
X-Received: by 2002:a9d:4702:: with SMTP id a2mr410773otf.319.1583889471514;
 Tue, 10 Mar 2020 18:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000034513e05a05cfc23@google.com>
In-Reply-To: <00000000000034513e05a05cfc23@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 10 Mar 2020 18:17:40 -0700
Message-ID: <CAM_iQpXLZ1PaG757i1NiQH9q+xuZAzhued0DYEGNH2XtAWZq2A@mail.gmail.com>
Subject: Re: KASAN: invalid-free in tcf_exts_destroy
To:     syzbot <syzbot+dcc34d54d68ef7d2d53d@syzkaller.appspotmail.com>
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
