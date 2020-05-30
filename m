Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388EBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEB420723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raIEaPAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgE3QJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3QJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:09:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23784C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:09:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d7so1445692lfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jcWNLhxXeAvkc4wgCt6uZZ2cQT7mLb+ZTkL7JbfnJOo=;
        b=raIEaPAE2S2scghaTHTDQBPXLWj9HRnjGJdiJYiGFrcZfZBGVxTYeCSL2pmkNbpc4P
         Sg4bbxsYwj1xahomGTSIu0sz2XsPcQpjFYN7CgTr47x+GbbgvLHfQEDcvRKzUaJ1FoAU
         eojvYkg8oOPZsnu86hAk3tQJeD+rSiYyeAAYs8ehGt2/sYDdrot3n/zzgTh4HkxXZzlL
         3d/qygtoDCNEOdncZyAZoIux5iz5VS57NWYp+9kXUb9WAGlrtUixRDxsODm3DjRVEa8a
         /FfGtATmj7Kfq3to8QgoyUIbJowQAcHKZH5tc+MnWusiuyPRum8abGm9XMn4tHu0bqFx
         iSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jcWNLhxXeAvkc4wgCt6uZZ2cQT7mLb+ZTkL7JbfnJOo=;
        b=H3J0+n4Ufqyyec9Oq3QZT2o4QtvVlIRv0QCz0QvAN90n0T06Xry3Ffwrs2sUslkhpq
         SaRZ+fIXjYKAwRqpK7cpsXNlOuetEprml6eqFmuxc8/g0QYVhdyrkhq3U8i0SZfcqx1O
         oeFbwWE+sZ6m5j4aTYSLw9mCsCfzCYfzQ51uWsjXLd1JtCxQqR+Tib2ZzscSqO0/eog6
         09TmsJRLNLVtN4olHKNzvJwbIvHnIO7Twyh4WmWvllMQA4pGSBNpA2Go9+mS4AvXvwI0
         fhCooD0UR+vPPkQKAfAPjpAb/pA8XTHOtxdBS0pchRMoerD/zSigq6JBMEv3KTtp3Zsb
         mvLA==
X-Gm-Message-State: AOAM531oWYjwe48qygcFPWbpsPwExsKIMHratXMi0AD3JlaLWz58V40K
        fYl3lnkQCZtz/H6eIT2mzTrVrF9eJfkm3jhoAdASaOgVwDoP
X-Google-Smtp-Source: ABdhPJzF2KTdwT1LfWzeauoCoCPCztCeRENL2gfimNB7GPgODpxAeYYY6GdPz4bnwFs9ncpHzYmmQKniTwFoJZ55DyY=
X-Received: by 2002:a05:6512:104c:: with SMTP id c12mr7220411lfb.200.1590854992269;
 Sat, 30 May 2020 09:09:52 -0700 (PDT)
MIME-Version: 1.0
From:   Mahmood Naderan <mahmood.nt@gmail.com>
Date:   Sat, 30 May 2020 20:39:41 +0430
Message-ID: <CADa2P2VcBsJU5Z+e6-=frxXFOiBxMtVKJ_4=-k1P3cHh9nY17A@mail.gmail.com>
Subject: Perf doesn't show build-id of the application itself
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I run the following perf command for collecting user data

$ perf record -e cycles:u -j any,u -a -o perf.data.user ./test

The output of build-id checking is

$ perf buildid-list -f -i perf.data.user
dbd41c586ea6789f3b998ed28be6ff37134e917a /lib/modules/4.19.125/build/vmlinux
b5381a457906d279073822a5ceb24c4bfef94ddb /lib/x86_64-linux-gnu/libc-2.23.so
ce17e023542265fc11d9bc8f534bb4f070493d30
/lib/x86_64-linux-gnu/libpthread-2.23.so
5d7b6259552275a3c17bd4c3fd05f5a6bf40caa5 /lib/x86_64-linux-gnu/ld-2.23.so
55a35b6df1526bf3d69586896785bf1df0bb4be6 [vdso]
59081d88e819c2fd3bcd8e58bc0c858c0ee2c3a9 /home/mahmood/bin/perf
8edd43fbf5a6d895172d205a7248a814e3b07bb2 /home/mahmood/kernel-4.19.125/test/test
2c0a469e1700fdd0b2f670737dabafeb9c38f909 /opt/glibc-2.23-install/libc.so


As you can see the /home/mahmood/kernel-4.19.125/test/test which is
the binary has a build-id. That is fine. However, when I run

$ perf record -e cycles:k -j any,k -a -o perf.data.kernel ./test

I don't see the application's build-id in the same output

$ perf buildid-list -f -i perf.data.kernel
dbd41c586ea6789f3b998ed28be6ff37134e917a /lib/modules/4.19.125/build/vmlinux
49b4a1a69bb9aebaca5147b9821e1a3a2ca759f3
/lib/modules/4.19.125/kernel/net/ipv4/netfilter/iptable_filter.ko
bb4e88298fe274b1bec7ba8ab24e6a9670b93d04
/lib/modules/4.19.125/kernel/net/ipv4/netfilter/nf_nat_ipv4.ko
ee37b9e0cc9b7be3ca543ecfeaa6bde28b77df7d
/lib/modules/4.19.125/kernel/net/netfilter/nf_nat.ko
2bc71fd8d0c750aa3427a31639ce75a16a3c288c
/lib/modules/4.19.125/kernel/net/netfilter/nf_conntrack.ko
e5dfa4829fe8f9ed3185b708225a5bab8d6d0afe
/lib/modules/4.19.125/kernel/net/ipv4/netfilter/nf_defrag_ipv4.ko
5d52d35a5b99dd81fed002ba571a7afe32b26cbd
/lib/modules/4.19.125/kernel/net/ipv4/netfilter/ip_tables.ko
d19830cb5c697cb2583d327c28aa3961c945005d
/lib/modules/4.19.125/kernel/drivers/gpu/drm/nouveau/nouveau.ko
b816c95c09032342acd644128cf4d21251b3578a
/lib/modules/4.19.125/kernel/drivers/net/ethernet/intel/igb/igb.ko
da3d32f0230efe8329fae49f9de60ddaeddf48a9
/lib/modules/4.19.125/kernel/drivers/ata/libahci.ko
b5381a457906d279073822a5ceb24c4bfef94ddb /lib/x86_64-linux-gnu/libc-2.23.so
55a35b6df1526bf3d69586896785bf1df0bb4be6 [vdso]

Is there any reason for that? I ask that because my analyzer checks
the build-ids and gives me an error regarding the missing
8edd43fbf5a6d895172d205a7248a814e3b07bb2 which is my application
itself. The analyzer has no problem with the former scenario.


Regards,
Mahmood
