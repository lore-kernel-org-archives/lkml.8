Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB72072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584645809;
	bh=7tYuzPr84WmpXJVgFCURm0xIWsB65MUiPCI9QIevoUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ehE/9rqfAgVpdqThRX8nUHpIqHaNcMF7PZSdXTh1bd4qEHwZUjlZR9SDo1E5IqRzF
	 sK9DJ/CzedT6j4jRll37DLVyYiQuyutI2wqQrZrckIAFho/vd6OJAacdn4QUAa1OwM
	 GPSGObj6VpfOUi3fgH5VXc5MGvYTQnjx0wVdSIgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCSTX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:23:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38756 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSTX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:23:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so3845408ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4I5MU6INIQxoy40TyJTvl6hTnSEinND8JTJgHzeaiOc=;
        b=fwZ6fzMXnJckO4nBROHr2q6xOqW5DtRnK+HV7FTclll+zT26Au8Qdns9yDBoQ7O8so
         nIOWCM6qDLDQh/v/ucUtI7mo95Q+ewJ5LXHA9AKsqpTCcHrTMb+qxEeYWqRmwOJCCtaV
         JTYvbWSg7N0yXWkzGUKN/1Jmn2BoxVkkl9QuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4I5MU6INIQxoy40TyJTvl6hTnSEinND8JTJgHzeaiOc=;
        b=aXypN7pO5gzIsZEDH22yc6ZhnXChJXHVIggXmPM8ZkowyEWJ8G8YAQfwPFNG2W8li0
         mgnJneEaFDMjPbNzQEq9Q3GlnH5E0KTEwD52Lvw1tD9/6xE5t9kPmTDElKgCUgW9fxng
         Hu1eizlJleSLY3INw5Ppnp+i47giaB8EH08yIDlJAklkVE1FHe93oTIiujA8WkstaDlJ
         /AJxKo4mIj/KDPFOajj2XAl08FNhoTdGVfseGQtKlLRaPVABqt2ue96xCcfTWczFoR+u
         /cfBI0CSDRI5lyMYbfitOIE1O2WtNAZ09ICnQTn4oDvcicZfH7jnlA0lxmy8cZpmtoVU
         tAoQ==
X-Gm-Message-State: ANhLgQ2uODixxKNQZ6/Uu6iM8mVLa9d03qvXUNhyp7vmhWDT43Bnm4sX
        dExN39rXRFl6uP4M5t9CiiOgja7elr4=
X-Google-Smtp-Source: ADFU+vvXCNUX4lsGqtl5W6fW3MG5JRrjrCN1dlcjXTxJqCHn4GwkGB1nx5ULeZEG4EYxq7HM2nOpTA==
X-Received: by 2002:a2e:b521:: with SMTP id z1mr3180580ljm.19.1584645804903;
        Thu, 19 Mar 2020 12:23:24 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t207sm2376229lff.72.2020.03.19.12.23.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 12:23:23 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 19so3827932ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:23:23 -0700 (PDT)
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr3220396lji.265.1584645803223;
 Thu, 19 Mar 2020 12:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name> <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name> <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name> <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
 <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
 <87pndcsxc6.fsf@notabene.neil.brown.name> <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
 <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com> <5d7b448858d5a5c01e97aceb45dcadff24d6fc28.camel@kernel.org>
In-Reply-To: <5d7b448858d5a5c01e97aceb45dcadff24d6fc28.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 12:23:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=UEVBObnZNtSnvX_9afJ3XHBSuXACPbriCBkCUGTHmA@mail.gmail.com>
Message-ID: <CAHk-=wj=UEVBObnZNtSnvX_9afJ3XHBSuXACPbriCBkCUGTHmA@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:52 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> Yangerkun gave me his Reviewed-by and I sent you the most recent version
> of the patch yesterday (cc'ing the relevant mailing lists). I left you
> as author as the original patch was yours.
>
> Let me know if you'd prefer I send a pull request instead.

Is that patch the only thing you have pending?

If you have other things, send me a pull request, otherwise just let
me know and I'll apply the patch directly.

             Linus
