Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0629C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8A5206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589209376;
	bh=wJAEzc/02JfHasTrBHvx5cDsjieGTWLTFqMSE7O7nfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AW2koLw1Ne1O2outu/C6T+/VOl/3VtqFIjtRAEbBhS+9oBlymIy4yYHcqxAHg0Cg1
	 KnKLkzrgYA6ZDa0uCt3YCkOrGohlSAkj5hvcLuEU1gReZm35idSEmo6socv0xkexu0
	 CF1Iu4jMGGkrUZpdXynthUX1D8oRlZYPB93Ey+dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgEKPC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:02:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:02:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id di6so4610523qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4uyWElSmmKaxd8Y7Hrt+yky6sisNiPUP3S3AyJYIE0=;
        b=TZ+MqzO4CQm/iAe5QqQybTl13BatZPT3cFASk8rIjwM92U6gr98iCpw6vh07s1Ogfj
         fnGdSk4VjTlUrMQgIhe0+aeZ5fHt0z4IdiAisI3XRA7gz+eaSYKtbpAZy4CayagjESqN
         iQSgzY3AOwyofH+xAZtSEGG0GYdWCVDnPU7705kMQN54DY1a/BhXVZUiPSFYSXJOJ1Og
         2f4ULbIBLnkP30TE6MBuUgrPNG0bBTy2hUgym3U3S3IvysQcdx4iH73NDwO9dG4QhDWx
         3B2lwLZDBboZR9drD783OFzUpIocAckq+bE/0TBXbbbYGbrO1Ikp+gMwXv/ERTRcCN+b
         NEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J4uyWElSmmKaxd8Y7Hrt+yky6sisNiPUP3S3AyJYIE0=;
        b=befBFFtv3KnSiAbrSG9Xh4POcRCOmb7BDpsDzHahMWaEB8FeFh+LuiUaTAjn3TkQd2
         /MPab8anZMsFZX3VrEKUnV3N5mA9KbReP2/SJtNqyV6sHMqb1hWXDNaZC3wpXx4Q0BYI
         fDVfNQ2h0sRkhDQ5g3uFohuZavt5j8PKeXfP4QgvjA0zMdlHSffmB/X0AZRw/DHZtjq3
         R8clF4nRfmbyRQZVtpA7JRFdotMIPT1pz0WLhjxmzsq/jcXeyu7dGk63U0DzqIcRD+Qu
         EgmefP0weQMZoS6+zRseJ5J0rN7+P2zUNg9lxONHC6TqrdR/gRR5x/ncuJHvSdSqs/Wx
         1tNw==
X-Gm-Message-State: AGi0PuYWtGNw8dLrPHi1kXB5woFfP+3LK/BRCQBTMrAJ2r8rPBL/0BRU
        YXUFh5d1K43gfpDxtW70wqw=
X-Google-Smtp-Source: APiQypLnPvgBUeyGBOEkrNHpMwu92fvMkq0NiRki3v6tGAI0dxnyEUhKlNYCkFNryl2NQrnC8dSGGg==
X-Received: by 2002:ad4:45a7:: with SMTP id y7mr6051944qvu.184.1589209374213;
        Mon, 11 May 2020 08:02:54 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id m6sm1054576qkc.4.2020.05.11.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:02:53 -0700 (PDT)
Date:   Mon, 11 May 2020 11:02:51 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v4 02/12] kthread: Add kthread_(un)block_work_queuing() and
 kthread_work_queuable()
Message-ID: <20200511150251.GE16815@mtj.duckdns.org>
References: <20200508204751.155488-1-lyude@redhat.com>
 <20200508204751.155488-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508204751.155488-3-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:46:52PM -0400, Lyude Paul wrote:
> Add some simple wrappers around incrementing/decrementing
> kthread_work.cancelling under lock, along with checking whether queuing
> is currently allowed on a given kthread_work, which we'll use want to
> implement work cancelling with DRM's vblank work helpers.

Am I correct in assuming that what you want is "cancel this and block
further queueing until the state is cleared"? I agree that'd be something
really useful to have. That said, There are a few areas that I think can be
improved upon:

* It'd be better if we separate this state into its own thing rather than
  mixing with canceling state which has potential to make things really
  confusing. It doesn't have to be a separate field unless you want disable
  depth for work item disable (and I don't think you do). It can just be a
  high bit in the same field but I think the two states should be separate
  one way or the other.

* I'm always a bit skeptical about state querying interfaces which aren't
  synchronized to anything. They're useful in many cases but also prone to
  being misused. If you absoultely have to have them, can you please add
  explicit comment explaining the lack of synchronization around it - ie.
  unless you're the one setting and clearing the flag and queueing the task,
  it isn't synchronized against anything.

* In the same vein, I'm not too sure about stand-alone block interface.
  Unless I'm the sole queuer or there are further locking around queueing,
  what good does setting blocking do? There's no way to guarantee that the
  flag is seen by someone else trying to queue it and trying to flush the
  work item after queueing doesn't help either. The only way to make that
  interface meaningful is doing it together with cancel - so, you say "block
  further queueing and cancel / flush whatever is in flight or queued",
  which actually gives you a useful invariant.

* A simliar argument can be made about unblock too although that's an a lot
  more relaxed situation in that unblocking and queueing oneself always
  works and that the user might not care which future instance of queueing
  will start succeeding.

Thanks.

-- 
tejun
