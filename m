Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B4C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8783C20708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEUK2qda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgA3XWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:22:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35929 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgA3XWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:22:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so5242724ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4pLYntMtcNk/QyMGMKvQCVzanZck9/zOb6bpHQ9EQI=;
        b=lEUK2qdaPMJDOGemYqUp9+l4fajGrH26MZzmOmKwRvhVulg3P4yB7FGm+fA6xHcnrg
         OmXPbaTxjRxGqphgXuDAxKiaGbhzxCaDTGn97OlZq7rOx9jcXKvKCdoyz/YO6ZS2g0q9
         kXs8OHU0qWGY3g4TCy3W2+cPIeFpfxgBi6SDAHHl80nS84lSrexIGj4KNGslTtgiffAt
         +D3IK5MB7DpA/4XHDT+H/85GEnGIKw6/sYNOGpRdt7inkPPh0ke4RC70c0e5CI0YVTW+
         bfVb4lF5bkE7knJ75b1MSAyjvEu0RYRDrb0nHQIedvptCIfMDsVIOxxldh5PG1iTs2Vm
         sCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4pLYntMtcNk/QyMGMKvQCVzanZck9/zOb6bpHQ9EQI=;
        b=rOUUXs3OPt04BTkiL8Hvm47WJeAqdQdOVM4LVD8TcE0foL4y4sTF8modRNGflpDLRl
         KoYB3OeHqNEYtFj1zlbR8kFpP7HKlByx/INfby2U31uZ1yw2IRVWT75F4Dqb8m41w8Bm
         GWRgnjc/47A0lXhxziQcS8bKVSansHcNznrnlrU3+wMxGigHPenKty5MZEDXUcbVSLHA
         08yYsliYYTO94LZXtY+5XwOjecl0+2Q1iN0B4uyrYa8vzaEwQF/Qro7c5lxsJaohMWHc
         t1SwnReb+iCOHRrk47KXnVJAqWGAZa2+ghhj9l8Er5CKK4uk0OLd+/6BOiNaDSO7rpxd
         TLqw==
X-Gm-Message-State: APjAAAXpY28Yb3+8xIy1Y28Em91qL4zb6HG2rOLvMjsXqcuvit2GbaC1
        rnaeS/L+hAy0gDsmZ7z3NtbJBmFd8ZK4/UX7MN4=
X-Google-Smtp-Source: APXvYqw/YlzAhwTZE6Giqw01b4YrMH0v8eLT4uWRQMvVdJUbTErJPFr5BqmT/vcBe29BoFwYiLzFDDqUJEBXR/set4g=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr4056104lja.165.1580426532516;
 Thu, 30 Jan 2020 15:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20191128135057.20020-1-benjamin.gaignard@st.com>
 <878snsvxzu.fsf@intel.com> <CA+M3ks5WvYoDLSrbvaGBbJg9+nnkX=xyCiD389QD8tSCdNqB+g@mail.gmail.com>
 <CA+M3ks4Y4LemFh=dQds91Z-LGJPK3vHKv=GeUNYHjNhdwz_m2g@mail.gmail.com>
 <CA+M3ks4yEBejzMoXPw_OK_LNP7ag5SNXZjvHqNeuZ8+9r2X-qw@mail.gmail.com>
 <b273036b10d8c2882800d01dcda7392e93b731fa.camel@redhat.com>
 <CA+M3ks5cuC5yJ-e0DCUiY1HtyyeU=mM9z56y4e_UduKaxcbw-A@mail.gmail.com> <08f4b69b1e48a81e90f28e7672da15cc5165969c.camel@redhat.com>
In-Reply-To: <08f4b69b1e48a81e90f28e7672da15cc5165969c.camel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 31 Jan 2020 09:22:00 +1000
Message-ID: <CAPM=9txafoQNfMFf0Ff1SnBTgq6jYyvjJyjCSJua6-SJVVkScQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix W=1 warnings
To:     Lyude Paul <lyude@redhat.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >
> > > hi-actually yes, we should probably be using this instead of just dropping
> > > this. Also, I didn't write this code originally I just refactored a bunch
> > > of
> > > it - Dave Airlied is the original author, but the original version of this
> > > code was written ages ago. tbh, I think it's a safe bet to say that they
> > > probably did mean to use this but forgot to and no one noticed until now.
> >
> > Hi,
> >
> > Any clue about how to use crc value ? Does it have to be checked
> > against something else ?
> > If crc are not matching what should we do of the data copied just before ?
>
> We should be able to just take the CRC value from the sideband message and
> then generate our own CRC value using the sideband message contents, and check
> if the two are equal. If they aren't, something went wrong and we didn't
> receive the message properly.
>
> Now as to what we should do when we have CRC mismatches? That's a bit more
> difficult. If you have access to the DP MST spec, I suppose a place to start
> figuring that out would be checking if there's a way for us to request that a
> branch device resend whatever message it sent previously. If there isn't, I
> guess we should just print an error in dmesg (possibly with a hexdump of the
> failed message as well) and not forward the message to the driver. Not sure of
> any better way of handling it then that

Yeah I think this reflects what I wanted to do, I've no memory of a
retransmit option in the spec, but I've away from it for a while. But
we'd want to compare the CRC with what we got to make sure the are the
same.

Dave.
