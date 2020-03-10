Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A57C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DD820866
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Co0nMb9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCJPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:46:54 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34507 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:46:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id t10so47673vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sm4E9m+LGUaQR6rC1v5sJxi5G7WnVBGz5OK0zEAN9bw=;
        b=Co0nMb9QaOSzcmqYW/l4HYb5lPCHntNoFCdQX+ZwbekNQpPMYlBtbKszJh8zubjoe7
         fBWPpVvSzO6setnDca0m5bvmw0Ot9ixJFIx5tqfYwlViGySu77C820EUuQz/5l1RICOO
         ltSUJGSxynnvGxHx1b7iEhaIxp96/YQwOR9Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm4E9m+LGUaQR6rC1v5sJxi5G7WnVBGz5OK0zEAN9bw=;
        b=BQMSSNohC/nSnXoNZaPxMuV+eL6EQYEkBjC/OTc47tOxAsYI/+33lZjrwpusuI/Kds
         DkgtlgZxycg03r/CbOswXNVmpSTXzh11c+4HBhxjEQ1S++MjQNLIINuase1iKnJmYiGm
         4TzbwDM28VnWA3jcbJ1+Bocvvf58unghi5htYiXqnqOUXFfBB6+RmxeXeewxwN4p07/N
         sKEukV/vT3GG6fNW2GcPRTP9+RnpY4Rw+0HAAv5sQZgEYIvBoa6cT9Mt/7RtklZ6efAP
         4J9OXOyP0QGwEKdMNppr+oMfgfD8q4e+Kgi8Qv3FxeaxWXh1u52WKNfDoFLG6N+MLg1D
         sOEg==
X-Gm-Message-State: ANhLgQ0fVgigHNcPOFshtzPs3KJJ4hz7j35GX0WpG13ZeVW74ijWVX8N
        sY1GfLNMEPLdSCP0yUh9JiWwDbFovVY=
X-Google-Smtp-Source: ADFU+vtUSVm41yIger1FFddQzRKOJJvgbI8daDzX+Y6o8VrCorw06elzq892dj3Dg/If4XvouUEvzQ==
X-Received: by 2002:a67:8843:: with SMTP id k64mr13506514vsd.195.1583855212539;
        Tue, 10 Mar 2020 08:46:52 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id o36sm10269006uao.15.2020.03.10.08.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:46:51 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id g21so2446317uaj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:46:50 -0700 (PDT)
X-Received: by 2002:ab0:6212:: with SMTP id m18mr1216115uao.120.1583855210519;
 Tue, 10 Mar 2020 08:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
 <1583746236-13325-6-git-send-email-mkshah@codeaurora.org> <CAD=FV=UugityQX+TG2c41dyaaCrhYe534UgXxm0G0igLz-9LSw@mail.gmail.com>
 <9bf2c0d6-29cf-47f1-3f98-e4bc9703b7b7@codeaurora.org>
In-Reply-To: <9bf2c0d6-29cf-47f1-3f98-e4bc9703b7b7@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Mar 2020 08:46:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UbXbYDzRMn-2P1nRa7y6a4sDH6GuWnnPuaHW4zea1v=A@mail.gmail.com>
Message-ID: <CAD=FV=UbXbYDzRMn-2P1nRa7y6a4sDH6GuWnnPuaHW4zea1v=A@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] drivers: qcom: Update rpmh clients to use start
 and end transactions
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 10, 2020 at 4:47 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
>
> On 3/10/2020 5:14 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
> >> Update all rpmh clients to start using rpmh_start_transaction() and
> >> rpmh_end_transaction().
> >>
> >> Cc: Taniya Das <tdas@codeaurora.org>
> >> Cc: Odelu Kukatla <okukatla@codeaurora.org>
> >> Cc: Kiran Gunda <kgunda@codeaurora.org>
> >> Cc: Sibi Sankar <sibis@codeaurora.org>
> >> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> >> ---
> >>  drivers/clk/qcom/clk-rpmh.c             | 21 ++++++++++++++-------
> >>  drivers/interconnect/qcom/bcm-voter.c   | 13 +++++++++----
> >>  drivers/regulator/qcom-rpmh-regulator.c |  4 ++++
> >>  drivers/soc/qcom/rpmhpd.c               | 11 +++++++++--
> > This needs to be 4 separate patches since the change to each subsystem
> > will go through a different maintainer.
> I will split to 4 changes, and send each one to its respective mailing lists and maintainer/reviewer.
> >
> > Also: it'll be a lot easier to land this if you make the new
> > rpmh_start_transaction() and rpmh_end_transaction() calls _optional_
> > for now, especially since they are just a speed optimization and not
> > for correctness.  That is, if a driver makes a call to rpmh_write(),
> > rpmh_write_async(), rpmh_write_batch(), or rpmh_invalidate() without
> > doing rpmh_start_transaction() then it should still work
>
> yes, this is already taken care.
>
> All the calls from driver will go through as it is and won't fail even without calling new APIs.
> So they are already optional.
>
> The comment in rpmh_start_transaction() is already saying if client "choose" to invoke this
> then this must be ended by calling rpmh_end_transaction(). if client don't invoke
> rpmh_start_transaction() in the first place then everything is expected work as if no change.

I think you may have misunderstood.  With your v13 it's not optional
because the flush won't happen unless the clients call
rpmh_start_transaction() and rpmh_end_transaction().  ...but the flush
is necessary for correctness, right?


> > --just flush
> > right away.
>
> No, currently also in driver no one is calling rpmh_flush().
>
> so nothing breaks with series and no point in adding changes to flush right away and then remove them in same series.
>
> when the clients starts invoking new APIs, rpmh_flush() will start getting invoked for the first time in driver.

I'm not saying to expose flush to clients.  I'm saying that you should
modify the implementation of the calls in rpmh.c.  AKA in rpmh.c you
have:

rpmh_write():
  start_transaction()
  ... the contents of rpmh_write() from your v13 ...
  end_transaction()

rpmh_write_async():
  start_transaction()
  ... the contents of rpmh_write_async() from your v13 ...
  end_transaction()

rpmh_write_batch()
  start_transaction()
  ... the contents of rpmh_write_batch() from your v13 ...
  end_transaction()

rpmh_invalidate()
  start_transaction()
  ... the contents of rpmh_invalidate() from your v13 ...
  end_transaction()


If a client calls rpmh_write() without anything else, they will get an
implicit flush.

If a client does this:

start_transaction()
rpmh_invalidate()
rpmh_write_batch()
rpmh_write_batch()
end_transaction()

That translates to:

start_transaction()
  start_transaction()
  ... the contents of rpmh_invalidate() from your v13 ...
  end_transaction()
  start_transaction()
  ... the contents of rpmh_write_batch() from your v13 ...
  end_transaction()
  start_transaction()
  ... the contents of rpmh_write_batch() from your v13 ...
  end_transaction()
end_transaction()

...then you'll get one flush at the end.  That's because the
start_transaction() embedded in rpmh_invalidate() and
rpmh_write_batch() will increase the usage count to 2 and then
decrease back to 1.  Since it won't be 0 you won't get flushes from
the embedded start/end.  You'll just get one flush at the end.


Now start_transaction() and end_transaction() are truly optional.  If
a client doesn't call them they'll get an implicit flush at the end of
every call.  If they do call start/end themselves they can postpone
the flush till the true end.

...and because it's truly optional, you can drop several of the
changes in your series.



-Doug
