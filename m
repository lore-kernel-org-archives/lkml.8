Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ED1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434DD2051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586629931;
	bh=erdAUWBPeP2EGyysKVScHC2rHjKmjCNeJ+ZViuEQ3r8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=klaEK3eVtJLAz4UeA9czSJ+DBjiD/+1fhmFsUZF1CVppSGFhbHEqRSOyl0x2UCf3G
	 hwooxoPFGpSV4gqTj4Su2BVPSP1moVt/P+IUjxm0E/oYZDscU7ffljrQvppwmdsCyS
	 zVYvI6kCSPlCpuC3OV/j/Fx0+ATbjwDE6a0dYtcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDKScJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:32:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45698 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:32:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id f8so3570249lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=187bxzvrtHFK3HWCV6zp/EP6I0ABzGoYnwq3TWAU7Yg=;
        b=IyEtE6/R37ytAiFvot4WlgVyugUBhYMX0XDQ8SkPp7XHYNji2CPdeg9sIdbbaKS0Vc
         cbuhHk9dpLyttnyCoexnf5KpIEBSnaVl4ZhWHe1VVBGkATELKxw6pvAZ5ZzoIk+tM5mF
         V9rrIyEYtLFqi1cI/02N09uGIbMjKuXamU7WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=187bxzvrtHFK3HWCV6zp/EP6I0ABzGoYnwq3TWAU7Yg=;
        b=PBmg82DsxgwnH+AtczbmyXqwFeu7s/R6xt/vIWoR4a7o1ggG+4TgWrRS3B6MX5GJpi
         9AjrbvhIDOngqw3GUzj6KB5yIXv6QY8fnJTyStGhbUyT91OIVruhwAuxY9fn8T9PnZ44
         fcFdV2EvB09llGx+egj/Iq8oXCBYI5+3QUO9jrQMF7DC+BlhDlgaNU2Bd2vOF0lCCGez
         F/6O/ul41MwXDS/I/9BTP/jgrbCLed1X2DB2WjLPvXofE7IAqyNJ0+ykMrpzvU1QSqis
         PtCrB3fBvm/w4+hh5WkmP/2ycPzdpKNnHanO78WtALcdIpv4yaeDZq388kpCfS4br8i0
         PrTA==
X-Gm-Message-State: AGi0PuawTL5rurYn0Q6jxuWRoqH00nrTKBEMOBlWRQRSr9pf4AySs38Y
        1G2dCiRGGvEyx02Sw9sCqRW7Pg7vwA0=
X-Google-Smtp-Source: APiQypIbD+2i3BaMMPuRv3pHDBlEkrPk7aDAiYCfpmcowgtW/dB0c4kdCNq6irdSm6jFy56uZ15fPg==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr4871242lfb.208.1586629924654;
        Sat, 11 Apr 2020 11:32:04 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a26sm3856419ljn.22.2020.04.11.11.32.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 11:32:03 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id l11so3596766lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 11:32:03 -0700 (PDT)
X-Received: by 2002:ac2:5ec5:: with SMTP id d5mr6014538lfq.142.1586629923314;
 Sat, 11 Apr 2020 11:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
In-Reply-To: <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 11:31:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU1kK6BrSUEm6=fwubjCYVX6bQsdTm-EkcwnPjV1KMUg@mail.gmail.com>
Message-ID: <CAHk-=wgU1kK6BrSUEm6=fwubjCYVX6bQsdTm-EkcwnPjV1KMUg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 11:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, you did it differently - by moving the "wait for dead threads"
> logic to after releasing the lock.

Not that I mind that approach either - the less work we do inside that
lock, the better off we are..

           Linus
