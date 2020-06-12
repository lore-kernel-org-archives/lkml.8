Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7699C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DD2207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1NO+FDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFLGTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgFLGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:19:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3FCC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:19:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y9so3901186qvs.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNGXv0lMsturnLAkB0xgOjhgswIgwH4CKsAWmGD9RnQ=;
        b=J1NO+FDS+jq8lTC9vJgDCCacRjwtmC1y1HcvYjSjs+teQ4GlLEmQcCRQUWKyqhqSrj
         BzDOXDCIji1ffezf77yz1B7/zFdMaENGO+eTMz4m/h7YG5qxYBsvyfDdU8rlGPBiHiSl
         QdY09wyaQLXNPh8u5W0CzK85KsSQ3+XkP0Xt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNGXv0lMsturnLAkB0xgOjhgswIgwH4CKsAWmGD9RnQ=;
        b=SAEyVluZgDb5yrL+xSzAapf1feNeIakoaJDsGnIc2CzPmu3cE4XPeCQMLJ27N+Munk
         3YHoNmEbDjoKeRauQEXPuyL1bgClkQPsdjk3b+FLffm59CFBh+CO5aviL2r42J3lKdU5
         BKTZrWLTpQ3h0BFYYUcBYbJK62tgvqY0BIyEG5/fzFA7t9KVJtQIHGshUilSI22cxEzE
         rnOkThoAKMbpwL3dO0bgG91M1JkDRDZb8/dNnavzcNNoaz7f2Rc6y+YhfdDJaFqnZXUG
         8ZcIDlRg8gD3fZpoeuQfFGhX2ReNA75NSIjmMenRAdT+JvhNLTqSG4eRXkf33CCjHwCO
         7RNw==
X-Gm-Message-State: AOAM5336UfGy2rV7ejiM9oMzfJjJECFAzqagChXqw6BQbN4lIN/aPOiH
        p5rbbBVFh23G7xLz8hyJ56tR7r7gBru6aQWOf4wQkg==
X-Google-Smtp-Source: ABdhPJxxLaXgILeWrAaRqOZ14vcxJ+konJwA4Urf9BTKUSLx6/pZ8w/DgK38RYaXnOjoSRt7jil1f7cCylhP6bPIZRA=
X-Received: by 2002:a0c:d442:: with SMTP id r2mr10699310qvh.59.1591942758671;
 Thu, 11 Jun 2020 23:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
 <2097432F-C4FA-4166-A221-DAE82B4A0C31@holtmann.org>
In-Reply-To: <2097432F-C4FA-4166-A221-DAE82B4A0C31@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 11 Jun 2020 23:19:07 -0700
Message-ID: <CABmPvSHKfS3fCfLzKCLAmf2p_JUYSkRrSfdkePVaHXSrLrXpbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Bluetooth: Add definitions for advertisement
 monitor features
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thanks for reviewing. Please see v3 for the update.
I am trying to settle down the name of Add Advertisement Pattern
Monitor command with Luiz on the other thread. I will post the update
here once it is sorted out.

Regards,
Miao

On Wed, Jun 10, 2020 at 10:57 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This adds support for Advertisement Monitor API. Here are the commands
> > and events added.
> > - Read Advertisement Monitor Feature command
> > - Add Advertisement Pattern Monitor command
> > - Remove Advertisement Monitor command
> > - Advertisement Monitor Added event
> > - Advertisement Monitor Removed event
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> > include/net/bluetooth/mgmt.h | 49 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 49 insertions(+)
>
> all 7 patches look good to me. I just need them be adjusted for the actual assigned command and event opcodes.
>
> Regards
>
> Marcel
>
