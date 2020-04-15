Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F22C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FD92076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586909043;
	bh=CxveRDxChEsZ3DATDUdDFICKjU4dpeGXHDzMXqWjub4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=UW1DnR91291SaOpHkiyrtYiH0L53RFccnL/27dTY6/Kf+MHy925HkhBTVzMRODo2H
	 Xda4jA5PDTq1wOBzxQ/wi9agZpub0uRpnqjVYFuYPJqMwMz1h8e304IqEI3Sf2tuPc
	 no6HlSeDngIBMVd6aEZ79RO6xNqwtthYyPdb4pj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634541AbgDOAEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgDOAD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:03:59 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3A62076B;
        Wed, 15 Apr 2020 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909039;
        bh=CxveRDxChEsZ3DATDUdDFICKjU4dpeGXHDzMXqWjub4=;
        h=From:Date:Subject:To:Cc:From;
        b=MMQ6ZP1NvuZOPVf062SlpWLaSJJIJEug4YdLWE3BSn3lrmDX0M7Hrwli3+L9CqePF
         tsbZM/peIWT0hBBs3hzftNAIbPAuuYnJnxdPEyNOsy18oEuXZlBBEEKGnVlfX/Yi7r
         FNPMkcdhyo4xRIkLEeSGE5iCI6E8lifQBAbqvQ8Q=
Received: by mail-ot1-f47.google.com with SMTP id b13so1661974oti.3;
        Tue, 14 Apr 2020 17:03:59 -0700 (PDT)
X-Gm-Message-State: AGi0PubYYw3d+syUEFcsGODlS6Zm6mp0YjPbJauTUkYz96zW7iBLPphY
        odd/bYU36LbOl7UeQvLU8mRzEPN+ZC3lqyE54x0=
X-Google-Smtp-Source: APiQypJgSB3aLxrmHPYHxXBc8JL6Jl2IrAaS334+PyIQmhLpm+RQQZeeKIrgk3KxIkG5ymimn2GhNK0KeJpZlqC7PHo=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr10319486ote.120.1586909038711;
 Tue, 14 Apr 2020 17:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5744:0:0:0:0:0 with HTTP; Tue, 14 Apr 2020 17:03:58
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 15 Apr 2020 09:03:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9O4F3Y11zAV5MGxhsTgCQNTL-9suKR0AZi08=bXDT5AA@mail.gmail.com>
Message-ID: <CAKYAXd9O4F3Y11zAV5MGxhsTgCQNTL-9suKR0AZi08=bXDT5AA@mail.gmail.com>
Subject: linux-next inclusion request : exfat filesystem
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please add exfat -dev tree to linux-next ?

git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git dev

Thanks a lot!
