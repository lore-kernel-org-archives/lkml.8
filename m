Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED952070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZKHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:07:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:07:47 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MV5rK-1iqLoa0Eg2-00S7X9 for <linux-kernel@vger.kernel.org>; Thu, 26 Mar
 2020 11:07:46 +0100
Received: by mail-qt1-f182.google.com with SMTP id z12so4726466qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:07:45 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0aKnnvqaSsXYRdJgrcMp/oIuXoaFacfkb53mUqRYSPvIc/QB0T
        Pn4hX4Bl8CiSeozFLM0vIh0pqBfAIzJLg5PaB3c=
X-Google-Smtp-Source: ADFU+vtn4zzbgXz0JiR+4r/VnSMlC2pOUeyfguA66WQGjarHPZXvLUyw5ij+hMENKb2uojnLZ7CO+lHSprkkhHJr/VE=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr7165503qtb.142.1585217264913;
 Thu, 26 Mar 2020 03:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <1576170032-3124-1-git-send-email-youri.querry_1@nxp.com> <1576170032-3124-3-git-send-email-youri.querry_1@nxp.com>
In-Reply-To: <1576170032-3124-3-git-send-email-youri.querry_1@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Mar 2020 11:07:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a11TJvNZ=uibXe8v6aHc3E8YTPeReN43=OW=3V7Rd7MNw@mail.gmail.com>
Message-ID: <CAK8P3a11TJvNZ=uibXe8v6aHc3E8YTPeReN43=OW=3V7Rd7MNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: fsl: dpio: QMAN performance improvement.
 Function pointer indirection.
To:     Youri Querry <youri.querry_1@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Zdku2WQfnX1DF8YXPQf1oMjKpWd4boAe7E2LVR2p4xWf7VV2m5b
 blLN7IUcUmb+iWznukDGkcx3AtrLJ5bD4/q5XH55UWmXSb7oUyc1YGjQm6TKnbHWLl00PtI
 Zku8fQ2Rgl14zUe1gvmCm4kDLfNwUA6xCZJ6xH3eqe5H743VxsyVdel9hh1PY4uiDAdxnXv
 wpUF6PZHeD9ZQWZIFZ5Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E4pX05TN0Cc=:muMnijKCpN5ohmdcVcML0w
 6qAX/PZWYlwdR5bskOiDfqpQDEFPkts5rhfvoCFv9oePVSJ03HLFi1jRDLgK5V5Y5ZM2bKMpy
 pvOJAW/NybCZIASzPz22a/VeQXUL0b0jvmp6mrgedcVHh3q8OGbHHYi7US7PbDUiRGoSEihUl
 daGsNwKridAkEQDQQdYTjwYA6zbgnBXexuDzQhr+taZ4Gba2N4xsM470nUM7HBoa69Gfd9XEr
 JNyJKGydojldwIGSkDwkSk3WIaJYqT3lEkJYsXH6QR1FeAdAT7iJ2D/ods16MfLEZDbX7vPgS
 NoCW4p/8r02K5UlhRDTky/vUPqXQuYHkpDR8wkXzu70En8fiD3OgOTz4XL+eJ0gHh9KhI6cdW
 E52mBp6YdtVAOlVZVGebxnvNT41ETL0drBXBnBwUfasAOJ8P+ixCPKf4V15sI+54GkMTnNmDm
 Ot3t3W34TbJMR7A7gM+84SnosJk9V3WwBMPbQqyrbiyHcLV94dD9COOkItO14/GK9WfuXIanI
 Ew/BSfUfQD1sk3Dt8eUaOgKg6HPt26I7Q32yyOXSUsjiPMYSFmiU1i9bXLtTzPg9wlt+BIh2W
 KT/HQ269Osl+CJStWEdziIkqm7oKxZO3CvgMJMAsNvujBYYM9xBKhTvlfThKKiuHjMQqiK2xv
 33LyfcSqrQ6OsZg816Of0LRi1Orzizyi7cc9gAC8Poezu0nSL3gWgd9HDVfqLo0kPwhfYwMuI
 98FfmdATXIinMBI/x0Y+VczC/Su5PJuKcRERS0231B5C0TXO+zhJ7szpbiicgE0kD+f0a+1du
 msMryCZ1YEKrrMtX7RkPNRZ4+qOgY8HGL9O82LDauHpP4iWNS0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 6:02 PM Youri Querry <youri.querry_1@nxp.com> wrote:
>
> We are making the access decision in the initialization and
> setting the function pointers accordingly.
>
> Signed-off-by: Youri Querry <youri.querry_1@nxp.com>
> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 451 +++++++++++++++++++++++++++++++-----
>  drivers/soc/fsl/dpio/qbman-portal.h | 129 ++++++++++-
>  2 files changed, 507 insertions(+), 73 deletions(-)

While merging pull requests, I came across some style issues with this driver.
I'm pulling it anyway, but please have another look and fix these for the next
release, or send a follow-up patch for the coming merge window.

>
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> index 5a37ac8..0ffe018 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -83,6 +83,82 @@ enum qbman_sdqcr_fc {
>         qbman_sdqcr_fc_up_to_3 = 1
>  };
>
> +/* Internal Function declaration */
> +static int qbman_swp_enqueue_direct(struct qbman_swp *s,
> +                                   const struct qbman_eq_desc *d,
> +                                   const struct dpaa2_fd *fd);
> +static int qbman_swp_enqueue_mem_back(struct qbman_swp *s,
> +                                     const struct qbman_eq_desc *d,
> +                                     const struct dpaa2_fd *fd);
> +static int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
> +                                            const struct qbman_eq_desc *d,
> +                                            const struct dpaa2_fd *fd,
> +                                            uint32_t *flags,
> +                                            int num_frames);
> +static int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
> +                                              const struct qbman_eq_desc *d,
> +                                              const struct dpaa2_fd *fd,
> +                                              uint32_t *flags,
> +                                              int num_frames);

Please try to avoid all static forward declarations. The coding style for the
kernel generally mandates that you define the functions in the order they
are used in, and have no such declarations, unless there is a recursion
that requires it. If you do have recursion, then please add a comment that
explains how you limit it to avoid overrunning the kernel stack.

> +const struct dpaa2_dq *qbman_swp_dqrr_next_direct(struct qbman_swp *s);
> +const struct dpaa2_dq *qbman_swp_dqrr_next_mem_back(struct qbman_swp *s);

Forward declarations for non-static functions in C code are much
worse, you should
never need these. If a function is shared between files, then put the
declaration
into a header file that is included by both, to ensure the prototypes match, and
if it's only used here, then make it 'static'.

> +/* Function pointers */
> +int (*qbman_swp_enqueue_ptr)(struct qbman_swp *s,
> +                            const struct qbman_eq_desc *d,
> +                            const struct dpaa2_fd *fd)
> +       = qbman_swp_enqueue_direct;
> +
> +int (*qbman_swp_enqueue_multiple_ptr)(struct qbman_swp *s,
> +                                     const struct qbman_eq_desc *d,
> +                                     const struct dpaa2_fd *fd,
> +                                     uint32_t *flags,
> +                                            int num_frames)
> +       = qbman_swp_enqueue_multiple_direct;

This looks like you just have an indirect function pointer with a
single possible
implementation. This is less of a problem, but until you have a way to safely
override these at runtime, it may be better to simplify this by using direct
function calls.

       Arnd
