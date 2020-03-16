Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2846C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A239120738
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqT9L+d/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbgCPTqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:46:13 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42862 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbgCPTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:46:13 -0400
Received: by mail-ot1-f41.google.com with SMTP id 66so19144233otd.9;
        Mon, 16 Mar 2020 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=FqT9L+d/z12NLuSeT3JrqFMnKilv4DWfJckRqN3s7x44mG05Dt295h39OD4Oi+Cryj
         +y88K4HcKPEqz1CZZ0z54c5NMFAp/R1b1zJZEnD6/imKqbg3iNBKdW0j9hMbXxcoHHau
         O9daOgKikTP8NO5otGV2veBUKB6h6wePj4mjQatfuaavjgZS1vck0XWezWWfpDJawwpJ
         LovCgFOM0ROSmBMRnsSddxYClXGNy3fpXvjDdo10gN8s1LZ3N0/RQeEo4AKIo4E5IKjK
         OYlnQSvrpgp9rcfBXnOd7xPwy5vUBg0nzPUJEhwsebLvEoH3BD7dbrUS8rpWZp+NXjkA
         XtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD9qGn/FmD1rIVTC9XP6vGVct8WmBBkX3v6FBswGPLo=;
        b=kzU620ZnROI8MH8OffE3/wYULHCfNTVX7OCsh5w06CX/1WllwfVHqeaHv9uMZYkIUO
         gfNlOQSEt5KAOZfDBo2CFmO4qWpFiQvFqNXdz26+VyAnIbC+AFa0xrnnRmCSIsszGgtN
         qKb+LMnmzAJ5wf7UHSuKvZ9jwm2a7UJSRd/k+WlrzMu9GG75PibRLMHPdo9tmfUH4ZHk
         aW3JhtlmjHvC8f+E5bf0R0zVRUZm/3ZD4CMvjGSNjhiEOSGMkf4OwYWO1eESCYW6J2DW
         DsNNTR/t3q3bIy+tivbc2FQ0Fd+kxQzzxVWDiVQsQDZgFvyK/D78e2RvnP5RD2i7aFEA
         pUYw==
X-Gm-Message-State: ANhLgQ3+AWzBP+Vh4j4n6vMpIxIQ2EyZapTmgTrM54L2+FAaXEWFAyRf
        7Ed7mCLTKmCEkD5wtCILERjr63KzYY3kF3ekXwA=
X-Google-Smtp-Source: ADFU+vtA7AzP+zXTm4BQNcSJHb20DfzuwnHnw+xS+lfJ+KbxiiJD/nA8Wgqaj1wL9kQWkN+9/TzCJDBQPXH5BQOJP6Q=
X-Received: by 2002:a05:6830:1e96:: with SMTP id n22mr692919otr.189.1584387972457;
 Mon, 16 Mar 2020 12:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd030905a0b75ac8@google.com>
In-Reply-To: <000000000000fd030905a0b75ac8@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 16 Mar 2020 12:46:01 -0700
Message-ID: <CAM_iQpXMckb7O6Fje30icqpHuhmzYNOx_ugnVWoOpgGteVTtdw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in route4_get
To:     syzbot <syzbot+1cba26af4a37d30e8040@syzkaller.appspotmail.com>
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

#syz fix: net_sched: cls_route: remove the right filter from hashtable
