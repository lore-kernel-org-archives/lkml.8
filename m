Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFAAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86EC20708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFVInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:43:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgFVInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:43:04 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MDykM-1jfYHa1vPw-009trF for <linux-kernel@vger.kernel.org>; Mon, 22 Jun
 2020 10:43:02 +0200
Received: by mail-qk1-f179.google.com with SMTP id q198so6920551qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:43:02 -0700 (PDT)
X-Gm-Message-State: AOAM531F+dL9yM9B+tMEYi6MgLr9wZrfFYSYV5Fg4VG3rq8k0jVoqyWR
        c49FIeJ7CF1LTC9TZTIW+5HJoasTwnb+JJv+ieY=
X-Google-Smtp-Source: ABdhPJxNrd6lbX99UbaBtKtbCfFJIGnBSM5gnDl6sHWd3fiqjDKmrzlo2eJ2AwXvqiPb8SFbUcjgdvWNsCjeyW77qTA=
X-Received: by 2002:a37:b484:: with SMTP id d126mr6219954qkf.394.1592815381304;
 Mon, 22 Jun 2020 01:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <202006211709.hxHhenC8%lkp@intel.com> <159281499670.62212.17969220355200979156@swboyd.mtv.corp.google.com>
In-Reply-To: <159281499670.62212.17969220355200979156@swboyd.mtv.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jun 2020 10:42:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3J_V3L_xyR8cRDHaYk1DLjoFaesQ-v+jW6hHk=NHncgA@mail.gmail.com>
Message-ID: <CAK8P3a3J_V3L_xyR8cRDHaYk1DLjoFaesQ-v+jW6hHk=NHncgA@mail.gmail.com>
Subject: Re: drivers/clk/clk-divider.c:39:17: sparse: sparse: incorrect type
 in argument 1 (different base types)
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XAv32ynh+qCHJjKXd/1LF9HJESqF9tw5mUcHRYDHYPXwrz6Gtwr
 Fz8VjoHuwUGnLnzVp4NeEWxRd8PM4fs8F5jQuqgneaSIFmb7NY7LQjbqQu8JB42lj5pj481
 O0FLznVWdUm3egsp/DXBUrnxIJhNXG95gaqHciZTTfymKeU/k6eDsvjjitRMZAY5aKGKhCi
 SgvHhkrJ5t6Y7AI9Es/YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jT6DMfx0kjU=:+dXY/7vKOVOkNdzf94Ld1B
 EJXvkubb9SCM7uJkb9tjQAP8DJCfazsd2O6J0j/zKBc1OOktVt2PPDcu5EfoEyxLLRdzESxcT
 vaG45iwKljTx0QUvbkZq34L823xY8VqaNCbAzEAi7TQHiPvqAk0UWCxlJEtEQVc0c5V5wBXqT
 yLzTy5hqrJ3JsdEjtUyFJ7Qz6o84dTBQMp2geXWULPfri5dBA6bnKB5tk/YjbaiUriABgUJwF
 PMDtbqJiE+yFgCy+pscB3XUjAyvkYFV180PRAqsL2S8DdUnMwzAeRc/5ON0C3ooNtcoRE93dt
 d0/mJdfRBa4JBbCF4ximQLmXGS3Eor3azZMNF8AFdl2OUoN0MdYw53shFqGUkBs05zyHLLKMk
 yTnKa15gzRkAvuRwOqaGQWt8j5rlp/ySAkYvrLVRR6XrzHTpYYlmfpFZcfVcRQkFDn5S4kian
 ELCaFgl28hRt0ndDMHlnR5mhSFDZt7f5Ujm6tdLbyhweeOag8EIyz05DUKr/l8PR7li91mint
 pBKU04XKkoVQ/AoNTHsWpuoU+kfpbAPWdJ37UiIs3f3ahaAEdaXiUP6wfZ9Wbfwp4st7hcRPq
 5bxPiaOqZ6bbk8BYBxI3gKc9M6u9wPLlthx7Oub57wqLh7x7+W74ahjC8h0bHlOlfIgy8D50S
 aQN9a1te4zT/KHYKTsrvX+jbZ0WH58AA+1ADongpdrY8q0uP3CuEuesmPEE1pqRh7lxjoVRbE
 Q/Ke3jiOmkl+NcFu4a39vL+MliWVRlRWDNtIrP10W1uvhquzW1DKxnQXoV9JWzc1Cfnma4z62
 jO/xobGtxJBFL/kltfee9I6U99OmdxSB9xLIhLr/doROR7jU3A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:36 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting kernel test robot (2020-06-21 02:05:20)
> > Hi Stephen,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   64677779e8962c20b580b471790fe42367750599
> > commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
> > date:   7 weeks ago
> > config: alpha-randconfig-s032-20200621 (attached as .config)
> > compiler: alpha-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-rc2-13-gc59158c8-dirty
> >         git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=alpha CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
>
> Ok. I guess we'll need to force cast the pointer to be __be32 in this
> case. Before it wasn't in generic code so the architecture was masking
> the issue.

I'm fairly sure the problem not in your code, but in the alpha implementation
if ioread32be:

#define ioread16be(p) be16_to_cpu(ioread16(p))
#define ioread32be(p) be32_to_cpu(ioread32(p))
#define iowrite16be(v,p) iowrite16(cpu_to_be16(v), (p))
#define iowrite32be(v,p) iowrite32(cpu_to_be32(v), (p))

This must produce a warning for any call to ioread32be(), you just got the
email because additional warnings showed up now that this code can be
built on alpha as well.

       Arnd
