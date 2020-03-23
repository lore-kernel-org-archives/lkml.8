Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4005C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0422076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCWJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:20:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgCWJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:20:47 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKsax-1ixnpw25sr-00LEkK for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 10:20:45 +0100
Received: by mail-lf1-f47.google.com with SMTP id j15so9609984lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:20:45 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0GpTDuBRNUkabkFbCbr+SjEjrn1KfpVUB+A9nbpR+bj7PO9ZeD
        Zn/HE9gzd7qx0pUkZtO3Bk4gAy5ibjqRM0ril2s=
X-Google-Smtp-Source: ADFU+vsdfIBKS2d397GWz/e6Dj/KQ1NxFjX2XKa6jOj+clU+bcm32wKXYAFLvIyGO6eG9h+HkWksvEjX56gMdEOJx7I=
X-Received: by 2002:ac2:57c5:: with SMTP id k5mr12166961lfo.207.1584955244957;
 Mon, 23 Mar 2020 02:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200318110204.GB2305113@kroah.com> <20200323045302.GA117440@sherlly> <20200323065506.GA131098@kroah.com>
In-Reply-To: <20200323065506.GA131098@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Mar 2020 10:20:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a29230XO8W2SWMQ-5z0nrtfWjPmh_4jrhjew+C=Qoaw-Q@mail.gmail.com>
Message-ID: <CAK8P3a29230XO8W2SWMQ-5z0nrtfWjPmh_4jrhjew+C=Qoaw-Q@mail.gmail.com>
Subject: Re: Re: [PATCH] VMCI: Fix NULL pointer dereference on context ptr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Marshall <hubcap@omnibond.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MAORhoA9uP5z6XPyNpl06IJ/5GMz+T36o3IV2Q4MOXn8uinSYKe
 C9diJ6ylridRej1w1L3zymbRSXYHJTXqqIuKDWpi6Jcy2MOQQCYyC0MUn0BYSaE6lmqH7Rb
 Mz/3d6g7ocGVmgZd5QZr0a2urso8J3QDe+5Y1Vm4cNrJIJbKgaZHfVOPJbZYCSKOjqO97l2
 QVpveyJyfrCW/3wjtDEVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JdF/Fd2FbLs=:nDU4lZS3E0qxBjXjoSUP58
 8XxjEprwW4F1KBqN+VhwVixHsNXk+RxieywCpmwEN33Ex77nSWl0QXVVQ1kyPE2dhYvLJOuHB
 Q23zaWPb7lwIpz9SmeALdxl3x2x48qUSe5x6M72TyHrFlJKNfk30qwpx1IGfu2OxmNguOmD67
 Kn+lIyYLiGez91rFJ9Ql+6/xFQ1SvUQjUmPLiHMlckxzrb2k3eFISMosD0yD4TkEiU3kIQhMu
 v8llHRe81aBXL2SlM2hf9DTCy+JQJ5znaAhu8igF0KkncsnXBfJ2YGkfGMV9BKx6J0vW+/sKc
 TKBidrZo9FXMT7fAfNQWK6ohlQqRAP+lbIcWca38N0dXJBMIa0Q/MBkql9x2g5ZdcATKmHs29
 n7ZjuWSKGwU6iVD3JjQMQ3SAOC0kj5GkChRcTuf4KWS9ohAGxIoIVhv9n7uoA4RpImyNcpnZp
 9rd19bOy/oIF4O30+7LvEOk+zbR2apW1a5UPODXH9ucbdIc/njFVLaTGVmmtD2LJg2rkbrFnC
 OU8+JRSzvU0uF69DJizN04s7QGmOUZDQAQ82tza4pvzIcnWQuRkWmY9iwtNOq9kRZ++imkhGw
 OsmYLLg0xLj/ecIv82K0M68lkfrV+QdJ7kdsVB/Qic8R5LqSzsj1+sSCXokfLZXt99fFo4nWQ
 9WhZtQVFrvc8SG1C3FOaH1JzbVpwlFCs/K0gAmqPGN70KHHKRhlKod0N958eAHDm22owmj3jT
 /JKruNMQnl7uNvlLttFQWzc2QSSb9JhOjPZ5/I/eh9wyllATCcuFxv2KA1dNH6OX80y2zdECb
 nQg9u/Zwf14e+ny57Z8+840MuBw3p5P8dI22c8CCePepZeBQVI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 23, 2020 at 12:53:02PM +0800, Xiyu Yang wrote:
> > On Wed, Mar 18, 2020 at 12:02:04PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 17, 2020 at 02:29:57PM +0800, Xiyu Yang wrote:
> > >
> > > Same comment as on your other patch.
> > >
> > > And is this a v2?
> >
> > Thanks! Yes, this is a v2.
> >
> > According  to our observation, vmci_ctx_rcv_notifications_release()
> > currently is only called by vmci_host_do_recv_notifications() which
> > guarantees a valid context object can be acquired with this context_id.
> >
> > However, we argue that a NULL-check here is still necessary because
> > this function may be called by other functions in the future who may
> > fail/forget to provide such guarantee.
>
> No, that's not how we write code in the kernel, if it does not need to
> be checked for because this can not happen, then do not check for it.
>
> Don't try to plan for random users of your code in the future when you
> control those users directly :)

Just saw this reply after replying to the other mail. I guess I picked
a bad example ;-)

If there was in fact a report about a NULL pointer at put() time
somewhere, that would be the first thing to fix, and it may still
make sense to review the other code paths to see if there
are additional cases that can go wrong.

      Arnd
