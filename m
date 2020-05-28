Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E996C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DF921475
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f06X9bMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgE1H7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgE1H7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:59:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAEBC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:59:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so3910845wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/k5PRZqrTr/okP/ue5AUSy+6fHt8kWqrhC3KChUGYlE=;
        b=f06X9bMILNGRerqSPyRUBylhnUHAyyk+VuMHZxYr8BmHOkV+aOhGS6lYLatqUsg+FJ
         WzjMl+sMuJI1Ujrzqb7qyecJzbgkPUhnMiF/L7hBH7q7OTRT8FUNnWdprgqB0UjHHGZB
         vt8agbDswCGjrwcKoQ2ljNeDVpcm0ungs40XB6jhy1imuPjrQwd+sNa8vvCONPO/Ebin
         2N0PRzBff5aOD/2LydaK2zdYgRfbUjU7zNeel6H7CNfIjuNS50fUpSfdaNgfc4tJHZwE
         trBjlHiEgpJJIqKjaWgaxrRBklrYlozg05PtTAxG6wNyEst0R2oMn1mP4a5E/ZkTFw1s
         Yc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/k5PRZqrTr/okP/ue5AUSy+6fHt8kWqrhC3KChUGYlE=;
        b=k20Eh4jrZBbMwXPucQ9QVutq0QmSzIIKOqikcQmZyd/19I0G2d56Ln+SDBkjxmgQ1X
         +8WIJImQzjRx80H/pu7q+sCtMdVYCHD9kRXeqTQnSaddXkZsNpyCvUs5Mis3bN9ge/Al
         u1mdCqDAvIq0ibz9yX+5a+IX1Qk1obHLKuE0bDM8+xNvP8N8IqYVJKe7O/FK++lpITil
         X9K7XfMzeQyHeaGgrwijs6ERKUlEuBpxBTJOjn+64jDii6yFf4G9DVC76K+Ip8KJ4sxj
         qvA9QmwFpKmubcEAhEVlPKpjaKiTjVy51shJyPzp8SrzhwAj6advyK/EJMZLuWoAUOnU
         JQOA==
X-Gm-Message-State: AOAM533xMCksi7JfZIWuN9k5zfALxHlBkW/Ka4h9f6tsFhBbeQKAuSq2
        kL92wlTUDvoU/DFlqJW0vLe0mg==
X-Google-Smtp-Source: ABdhPJz8hbY7QI6ZmAP07xr1w3ABtn59eI5lHeeg/9O0ZaDlaJSV/s26Z5yge3qDhTRGa+y8nI6ePg==
X-Received: by 2002:a1c:810a:: with SMTP id c10mr2106423wmd.107.1590652746531;
        Thu, 28 May 2020 00:59:06 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id d13sm5375172wmb.39.2020.05.28.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:59:05 -0700 (PDT)
Date:   Thu, 28 May 2020 09:59:00 +0200
From:   Marco Elver <elver@google.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com,
        arnd@arndb.de, will@kernel.org
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Message-ID: <20200528075900.GA236442@google.com>
References: <202005280727.lXn1VnTw%lkp@intel.com>
 <20200527235442.GC1805@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527235442.GC1805@zn.tnic>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020, Borislav Petkov wrote:

> On Thu, May 28, 2020 at 07:39:31AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git loc=
king/kcsan
> > head:   a5dead405f6be1fb80555bdcb77c406bf133fdc8
> > commit: a5dead405f6be1fb80555bdcb77c406bf133fdc8 [12/12] compiler_types=
=2Eh: Optimize __unqual_scalar_typeof compilation time
> > config: i386-randconfig-s002-20200527 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
> >         git checkout a5dead405f6be1fb80555bdcb77c406bf133fdc8
> >         # save the attached .config to linux build tree
> >         make W=3D1 C=3D1 ARCH=3Di386 CF=3D'-fdiagnostic-prefix -D__CHEC=
K_ENDIAN__'
> >=20
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> I'll say.
>=20
> Looking at the subject, that broke the 0day bot too. :-)
>=20
> /me trims it.
>=20
> Looks like we need __CHECKER__ ifdeffery somewhere but it is too late
> for me to think straight so tomorrow...

Ouch. The below should be all we need, assuming it's the best we can do
for sparse right now.

Thanks,
-- Marco

------ >8 ------

=46rom: Marco Elver <elver@google.com>
Date: Thu, 28 May 2020 09:43:13 +0200
Subject: [PATCH] compiler_types.h: Use unoptimized __unqual_scalar_typeof f=
or
 sparse

If the file is being checked with sparse, use the unoptimized version of
__unqual_scalar_typeof(), since sparse does not support _Generic.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a529fa263906..c1ee20812a8c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,7 +246,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
-#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(_=
_CHECKER__)
 /*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
--=20
2.27.0.rc0.183.gde8f92d652-goog

