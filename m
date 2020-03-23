Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1189C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4702072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCWJRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:17:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgCWJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:17:08 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbSTX-1jni9K2Owj-00boLm for <linux-kernel@vger.kernel.org>; Mon, 23 Mar
 2020 10:17:07 +0100
Received: by mail-lj1-f180.google.com with SMTP id r22so6607802ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 02:17:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2LLqSSiCOKUikf2HzOk9li15WMoY5sz3UqzYY7+hlqd169B02W
        L1Fwhx4gRsh4g1arizGcXQhZXn1B5cOutpCgk9s=
X-Google-Smtp-Source: ADFU+vsLiBt92J24W4vF4BdBvOu5ulnsedjxfYCLZIsARWMfILgyVP+qxu/Co/b9PntyU/zNaFEbgt0txLEaNs07lAU=
X-Received: by 2002:a2e:b446:: with SMTP id o6mr884610ljm.80.1584955027049;
 Mon, 23 Mar 2020 02:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn> <20200323085241.GA342330@kroah.com>
In-Reply-To: <20200323085241.GA342330@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Mar 2020 10:16:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3B373YcmZncnE-wJz12B+3A5QC9CUrDd72qSw+65MwQg@mail.gmail.com>
Message-ID: <CAK8P3a3B373YcmZncnE-wJz12B+3A5QC9CUrDd72qSw+65MwQg@mail.gmail.com>
Subject: Re: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu DASA <vdasa@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:p2CbdlkU9xltPiBuzaWO3iobYWXmv/5X0iVbX/5mbO8GQaJPxEe
 csVPp7iA5CKtudNfHCaeRPtpYX+Pa1qqSxpQtl3sK3oOia000jdBYnBH1QwWV5jEjxmLyc+
 Y97n50Z/oQ5WSelnRWnJtfOGGKb/l1AEKycpwXcYiP7zpz6Ni0Zhuzm50ghywmAGFTIWBVx
 K8xMei5U6m/4+Lx3K2YdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o8OQ5dISASE=:j8RMKcp6xJ9zifV/7LnPrE
 uimb1RqS7PhFoyf4iAqqNKat2a0CZY5PbLDkwNI3UT/1KblxfwGnwCZCX6cUEUWx3lOCLga32
 M1D4lb+XyCo5jG8FMiRnd5SVGDoLCxt1wqel1YNA0SEkgMICzFaaXiK3ZZcNBLcmMazXSLl3q
 Sgjr202c6a7RAukBqywe57Pyrxb7fZg70QC/dEtr6ZkL5NpvXasT3x6Q1XEngZa5Ye+AFPohW
 pfJjqpCJuyJuDKmB/qvnFAidsSc4EgfCEtUWiBq9pyqLJHvcfIDFJ0tu5tAvjshp7WcbFlaAp
 NThVLZXdE5Rpt6Cv3q6ltS5ymk3L1VnoWHOqF0w4FH8/QNYldRpt76qwQ/S2rYYT4gcyiJmLW
 D6LZIsze8EXWZf5XVIpaM/fwZN74vEY5XZe/NtzMxdAguesMZwgmfzgcrbjSLN3j/gvpSE0aB
 GJm3Hve8gnYGyF/0kwsXSHNayN9HCb57fIniX9WpHqQzL3HMu5V24bizj0N8/ts/SDCoezhoF
 oF7bQ5dU2iAEtPOekMbx071EmvnvpO7soIuA8AIOn9Yq/+hBkfl0vxYnjc1x0wriB0Yw4W1RN
 ifeqTnXqn3HzQe8BUf6NmhnjXOohsw1O3EEb4VyQQWjHASB1jW3nkCflDi8fzF9C72mltjC3l
 umQI6CjL67f+uUehVgnIw+o7bj+3zWOLMtYlx1bobHyXUrByeGI/VimQcnCWx9v2pTLtlMhzE
 BKSCS+JHR2l/amccSt629LU9CtLJ2jXMs/C1en+gmzwCxdC0Bd3oBcoohvpNeuKklHx0vzNjL
 GvV/OvJVFDHU+hsCEjD7JAjoaRVX9bhooYPi5GptAQk32L+hw0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 9:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 23, 2020 at 04:22:33PM +0800, Xiyu Yang wrote:
> > A NULL vmci_ctx object may pass to vmci_ctx_put() from its callers.
>
> Are you sure this can happen?
>
> > Add a NULL check to prevent NULL pointer dereference.

It looks like this could happen if vmci_ctx_get() returns NULL, which is
not checked for consistently. Maybe add better error handling to the
callers that currently don't check for that, to catch problems such as

void vmci_ctx_rcv_notifications_release(...)
{
        struct vmci_ctx *context = vmci_ctx_get(context_id); /* may be NULL */
       ...
       context->pending_doorbell_array = db_handle_array;
       ...
       vmci_ctx_put(context);
}

Checking only in vmci_ctx_put() is too late.

     Arnd
