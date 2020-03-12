Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF1220674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DZqs4TO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCLPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:17:56 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39370 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:17:55 -0400
Received: by mail-qv1-f66.google.com with SMTP id fc12so2782820qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucB0jSYs7otvL+Roe4QFbncbHLIRwSx5DdcgmtIHpGI=;
        b=DZqs4TO/YQ1WXVFv4NNXH/1f3ChovaXoOleqUsNYg1faonPhV3acnKgRE9fakNAfQ+
         ojunQdZ18rtTzshYz8pc69vmqnTIrLJ/nAqGlbFAZAXa0oFo402XVNje7hc3PK9vBw6P
         bIGSwaNxXi/Xq5+7Ish4Ljnw1JIJlvJkO/jt+NGa3eAkA5CPprRXfXJZQ5b4JJL5ciw5
         XIuOGnQjX5HVPZ+v8/CuyttFyl6Z804UvSd1RwehT1BeFDPehqwsJAf5ydsT7CCqK9cz
         rKh/yd9Kogy7wrxs3oe8oi+Qxg+qjvwJ0O1wpIUXJ3davcOEOvvGHer0Nd2COT8NfLXb
         gPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucB0jSYs7otvL+Roe4QFbncbHLIRwSx5DdcgmtIHpGI=;
        b=uWnO1jo6RMHvP3vX7+KLO+kRB+nvtg2R+fq/vYy1mjyczC2XS88q7Ba8fadwFOSgsm
         Mfk3qYXZtq3Ve6H3/qmjjY76W3cuvY6eQuveOvGHZ3ozef+6uEbrWJCnu/FCvnZngVrp
         6DG738XnrkA4Yu6H8t7xWZDyZDr8rokwR8b+5YSFDlOTRylow0JlHgxlMlY72zEEPFOq
         OcuxPiMvYHgOAYNXUSqmC7y12bpcQlOKTeZgZeGN8vkDQ5d9EyzLT+kjU94o7NiX0S7O
         zMyryiUKymfev+H8zeFxcK0y89a0j/NqqSkVP3i/H7XcMH60s6eSpmykH1a3bx4ujHZP
         r15w==
X-Gm-Message-State: ANhLgQ348p0CCyGYvLMT20DQ68cer6CY75uiNRDuv3KkoX3Pd2GQLYU5
        Pw3tF2lQ5jJBv+OFVzHYkzy1SQ==
X-Google-Smtp-Source: ADFU+vsie6w+TM81UO1bRct3BslZgyNzyOBijs1IZJ0N9tNY/N449Z2WBPij8ldirt/oZ1ctWF5yaA==
X-Received: by 2002:a05:6214:1351:: with SMTP id b17mr7980984qvw.251.1584026269849;
        Thu, 12 Mar 2020 08:17:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x188sm18344452qka.53.2020.03.12.08.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 08:17:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCPam-0007eN-LV; Thu, 12 Mar 2020 12:17:48 -0300
Date:   Thu, 12 Mar 2020 12:17:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, kamalheib1@gmail.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: ODEBUG bug in remove_client_context
Message-ID: <20200312151748.GP31668@ziepe.ca>
References: <00000000000041c6a905a0a295ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041c6a905a0a295ef@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:37:12PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    61a09258 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a6d70de00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7aef917d2e37d731
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3b8c2a85d37162cc6ab
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com

#syz dup: WARNING: ODEBUG bug in smc_ib_remove_dev

Jason
