Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D2720721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLZScCpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgE0Qnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgE0Qnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:43:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479FBC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:43:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g9so20783412edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3q9WnY2dgTl7TlEf2k7hlRB1KrABTBeSJ/DQbUVUQU=;
        b=YLZScCpzoaBLES+0/nSnkmHX6TtFUctRClwrnq8aj1bSDnXi2aWhmNVgXA4sRTBznC
         k4enGbRI5w1h+J8XMLV4KlE8bPxqi9ljvQyH7J9EzqhANBGrRR/Yt4/a7DklzNpmsoc2
         p1nEcILEjtLHWYt4I3CIeLyrqx7JpzxwR2QqaOgaaLVt7++8tTGXLKaxSxjbrT6y1jwb
         5Pr/oMhkhQcyfxZp6wTnj4n9LfW8W5g+33GUyhjJ6aabvtB3UbKyHrwJK8HaA17d/lcs
         iJJ5n5DhD/LFy/ZkJFS4p/ogxOa0JgTm/AjRGFFbpbcmMcrBrRrTV+ff7HtZEPBLhQe1
         A8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3q9WnY2dgTl7TlEf2k7hlRB1KrABTBeSJ/DQbUVUQU=;
        b=Rg+rsK/AvGVbxyE9Jlf3tu0lJYwzDUMG7aq/hSSEXSxzKxMFmFZMpaFeUjM5cQAV/s
         n/slD/6CJYySR2Y4sW0UMrZKWtXtb7qOuZAI853lwqqSHKUXCqavitSWNiV4GO2Xd6xI
         I3akEQ2+2Qgi//CPvbh8G8zvpuCut0LR5OWzbHdydUutA9nQRS6Yge62A+3Hlg50s5Fn
         PgmHUTIqJUzMyRsojYBwAiMytTnhMEGtFc44wQfRp92Jv31dmtN4HN3LVajiJDGPUMGx
         Oq9m0rsqybiABvRPbXXNED+x08i3KDny+Okxo4th8Hhf35aesd1vY8p6FZIiwJvEAhTN
         6IHw==
X-Gm-Message-State: AOAM531bxdTldlBZv9IqPYsbNcNVq2QyDicpRpxgHu6RfCaO5ON2xWBv
        98gdJFwufGvrLFo4kgo/ERL1B3ZnIglOPBTQ5E0=
X-Google-Smtp-Source: ABdhPJzYq10hdHIXVNzq8WeRAPKlPlEDvHMiX5YtnDZiNoUA757RAfPHUvEyJLkD9YIlt49Btq0DRMwIZk3hRrICpl4=
X-Received: by 2002:aa7:d8c2:: with SMTP id k2mr25118933eds.145.1590597820982;
 Wed, 27 May 2020 09:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200526145454.GZ30374@kadam>
In-Reply-To: <20200526145454.GZ30374@kadam>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 27 May 2020 19:43:29 +0300
Message-ID: <CA+h21hqw8Ed_k_E8KK7mzDTag7p8jTYFLLkJ_i6+8__BKCdEUQ@mail.gmail.com>
Subject: Re: net/dsa/tag_8021q.c:109 dsa_8021q_restore_pvid() error:
 uninitialized symbol 'pvid'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, lkml <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Tue, 26 May 2020 at 17:55, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9cb1fd0efd195590b828b9b865421ad345a4a145
> commit: c80ed84e76886487703bf04b38ce10e92e2d6e26 net: dsa: tag_8021q: Fix dsa_8021q_restore_pvid for an absent pvid
> date:   6 months ago
> config: x86_64-randconfig-m001-20200526 (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> net/dsa/tag_8021q.c:109 dsa_8021q_restore_pvid() error: uninitialized symbol 'pvid'.
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c80ed84e76886487703bf04b38ce10e92e2d6e26
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout c80ed84e76886487703bf04b38ce10e92e2d6e26
> vim +/pvid +109 net/dsa/tag_8021q.c
>
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30   96  static int dsa_8021q_restore_pvid(struct dsa_switch *ds, int port)
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30   97  {
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30   98          struct bridge_vlan_info vinfo;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30   99          struct net_device *slave;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  100          u16 pvid;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  101          int err;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  102
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  103          if (!dsa_is_user_port(ds, port))
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  104                  return 0;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  105
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  106          slave = ds->ports[port].slave;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  107
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  108          err = br_vlan_get_pvid(slave, &pvid);
> c80ed84e768864 Vladimir Oltean 2019-11-16 @109          if (!pvid || err < 0)
>                                                             ^^^^^^^^^^^^^^^^
> I don't know why this warning is only showing up now in May 2020...
> Anyway, we could solve the problem by checking for errors first:
>
>         if (err < 0 || !pvid) {
>
> The UBSan tool can detect uninitialized values used at runtime so it
> might generate a splat as well.  Other than that, obviously it is
> harmless.
>
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  110                  /* There is no pvid on the bridge for this port, which is
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  111                   * perfectly valid. Nothing to restore, bye-bye!
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  112                   */
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  113                  return 0;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  114
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  115          err = br_vlan_get_info(slave, pvid, &vinfo);
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  116          if (err < 0) {
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  117                  dev_err(ds->dev, "Couldn't determine PVID attributes\n");
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  118                  return err;
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  119          }
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  120
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  121          return dsa_port_vid_add(&ds->ports[port], pvid, vinfo.flags);
> 5f33183b7fdfeb Vladimir Oltean 2019-08-30  122  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

For net-next I just sent a patch that removes this function altogether:
https://patchwork.ozlabs.org/project/netdev/patch/20200527164134.1081548-1-olteanv@gmail.com/
Do you think a patch for the net tree is still necessary, that
reorders the checks? Will you send that patch or should I?

Thanks,
-Vladimir
