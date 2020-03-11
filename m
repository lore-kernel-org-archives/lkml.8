Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D19C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C18D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583900606;
	bh=FaPkAhROiBnhx8TcXtQCbBXAx6LE4N7UcMmd5rbePkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ju34e7/nPTK8aKBRaER8/7HHvVBpojA7wcZZlCiemNxnUgDcl3a1/saGmdQ5wvxn/
	 xNc4IUjAWP745l0irTm/owyYo+Sh0YLe1ZXNtSqAvKeeLopDRqp6EkaUu9ZhiiXhZA
	 zzY6iGlxMyprB8qBZVkTD82nF/SfPS9oRvEZumeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgCKEXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:23:25 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35692 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgCKEXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:23:25 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 02B4NDEw031353;
        Wed, 11 Mar 2020 13:23:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 02B4NDEw031353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583900594;
        bh=D34pHK0RFulSRoIYPAPeyEM8GpXVGs0kK0sAr2243Jk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d4pYut8wCPq5aa/7Zw7vMLJK0pyiaCpDnIXiKq82adJ7+tJsCg7jg//5aiZtc848F
         rOm7abD9cemq+3EJxgAJaHMArtRhXWF6F4/w9R6idF3HAIU/TEGjAOkD/VFuogwKDr
         5PXmnCjfkV6Zyx6fRNQVfOIu3nDD49IQp99K6Nn3K2YLu+kX3wZO6azFSEWb1U8n69
         n4EXdIpeYlDh96CqDu4QAPuoATUdiR9r+vyc/Wzi+HGvsIs/tTCeyXu78l9MPCe2Lt
         NliwAk2qNyv4K1ZYATnItFA6RP8iwPPbThkmClZlhOCYkertBxVEmsNVMqlExGwEY7
         FWBrTlQgsCE8Q==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id g21so247918uaj.1;
        Tue, 10 Mar 2020 21:23:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1AA3EwkRUpQo6Og7zymBGvCWhmdGzqd6KIrdR67clacs8bU0D7
        3L/Bi4K4sZx+1hlqsETd/2bVjeGBYMsSVoHAbJk=
X-Google-Smtp-Source: ADFU+vuGf8cuwxCb/5JsZbCbmJEl0UWpBpVQYM9pwDP7QyQHNOGRyKBKssHZk11vU3CPs1PX27P2wukXXPVR3KS+XAY=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr558341uar.109.1583900593235;
 Tue, 10 Mar 2020 21:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200311095319.30e14ac0@canb.auug.org.au>
In-Reply-To: <20200311095319.30e14ac0@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Mar 2020 13:22:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmD5AaHmgpSk4Z8+NPd0kwSrVQnnx27vPci19KJ0+DPA@mail.gmail.com>
Message-ID: <CAK7LNARmD5AaHmgpSk4Z8+NPd0kwSrVQnnx27vPci19KJ0+DPA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Wed, Mar 11, 2020 at 7:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> x86_64-linux-gnu-ld: net/core/devlink.o: in function `devlink_trap_report':
> (.text+0x4e7e): undefined reference to `net_dm_hw_report'
>
> Caused by commit
>
>   af20db858358 ("kconfig: allow symbols implied by y to become m")
>
> At least, reverting that commit (and commit
>
>   d590d0a6e6fe ("kconfig: make 'imply' obey the direct dependency"))
>
> allows the build to work.
>
> Advice, please.  Does someone need to audit all the uses of "imply"?


The following patch should fix the build error.


index 2ab668461463..f68bc373544a 100644
--- a/include/net/drop_monitor.h
+++ b/include/net/drop_monitor.h
@@ -19,7 +19,7 @@ struct net_dm_hw_metadata {
        struct net_device *input_dev;
 };

-#if IS_ENABLED(CONFIG_NET_DROP_MONITOR)
+#if IS_REACHABLE(CONFIG_NET_DROP_MONITOR)
 void net_dm_hw_report(struct sk_buff *skb,
                      const struct net_dm_hw_metadata *hw_metadata);
 #else




I will propose this fix-up in the net ML.



-- 
Best Regards
Masahiro Yamada
