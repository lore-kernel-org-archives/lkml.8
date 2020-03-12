Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C53C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD77A2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEninoqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCLX3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:29:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41261 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:29:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id s15so8197296otq.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SrXir/YgLmKNV8EO2FeOi/klFesqmPLGQV20jNe7/M=;
        b=kEninoqgPIQTfnaEho6NJOK7ErgmrjSnhy5gnF2yFUGNwMoldjnefbNmyvBAW9rygR
         NJZxw2sotojnsm3T0PcPiiRYlSUktyiEMsS87a+zOozEfavJwPoeMytmViQZwksAqYoN
         25TuNEYGkJPH2Y9N90yAismRYtYdpVpocsjWVVHkb2MLzaqxjD6f8pVPLTcD0KjtYH1f
         EpyVee2cMWK+s4/3D1pxjAl5m0EQiIhbh80J/9e10osvHBU6OtTd7nsnGtmoibUWqCNf
         xF3okHdqCtaBqd13O1ZR+IQlAbRxZJdKWtFj4RoMqb+V1tAM5dBA5r45fGc7Z5g5Wnn6
         iGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SrXir/YgLmKNV8EO2FeOi/klFesqmPLGQV20jNe7/M=;
        b=jc26iEq0R+urhQauOwZ/ks/jVXaS0BEu6LHpJTcfjAtywVKo6q6lWE8NANl7kpiumC
         g6zEBKvmMWFHvaOZh0GJPxOakQBlx7Q216A7/XpqemUQkWVoQru8NQLqO+YFc0pi2Zeh
         qL7W6STxJdQRX4s//pdTwbLOMxylRtRWxX6hFW0XCe5NcJoST4/E2cBDDBiIZ/hN+sqk
         9u9PK7Q+LNTz8ST2Q28KpRPJ1TjRVcDGHN58rjQDoY4S/BiYPMK2qAXGKRf24lYhKjKY
         SjTOCM0GHNbd3URxE8x65OOIlgBD3Gm8JUs7tgIUYfSR3KzUEZ+lDHQOjzibQY7HnqlP
         PNDA==
X-Gm-Message-State: ANhLgQ0+Bpm9xVX42WDJ7tIBCFD0poRltk/SMTOwbmthwDyFWsfomzgC
        0/LYIQTTAm/jhoLmjz5aTaVofbbRj4ABOJsiSWTDVkPL
X-Google-Smtp-Source: ADFU+vsCquH8N50b/h7erdYjEqOA9YkzqeC+q0ryNjQMYjBc8t9z3PAstKQUfQnwSiDSGjJcYQ0Y80lQMtJ/l1ao7B0=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr3253566oto.228.1584055791321;
 Thu, 12 Mar 2020 16:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz> <20200312201602.GA68817@google.com>
In-Reply-To: <20200312201602.GA68817@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 13 Mar 2020 00:29:24 +0100
Message-ID: <CAG48ez2JKTk8bs0_YcofxUA-oLYdBCWSzGRS2fzBHAQ==dCz5A@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 9:16 PM Minchan Kim <minchan@kernel.org> wrote:
> On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > [Cc akpm]
> >
> > So what about this?
>
> Thanks, Michal.
>
> I't likde to wait Jann's reply since Dave gave his opinion about the vulnerability.
> https://lore.kernel.org/linux-mm/cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com/
> Jann, could you give your insigh about that practically it's possible?

Since I don't really know much about the whole LVI attack, and in
particular don't have any practical experience with it, I don't think
I can help with insight on that. So since Dave said that he doesn't
think it's practical, I'll defer to him on that.
