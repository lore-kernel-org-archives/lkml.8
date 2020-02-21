Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C86C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977A920722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582267311;
	bh=P+lKiv1d787VDGVdhhdfylLnYV7ZSQyLH3Xi8jpXxrk=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=lE8e3NO2Xnh6JNpm+xPn92tZ+LlQdI8sz9gQKS+D/a5AWkTWVEBzmEibshIWx7Z3/
	 /ApxPxc49LEHFwYzFsLTQfSPhJzs+aKTx3FVD1O5P9gWafevQE78eIXsRqljkLGrLf
	 MxBB86WiVkRShItUgTApBiw+jAvaEVrrZrOhZNsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBUGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 01:41:50 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44021 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBUGlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 01:41:50 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 01L6fOtD002177;
        Fri, 21 Feb 2020 15:41:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01L6fOtD002177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582267285;
        bh=w9qQFtOkV425rrij+z9xWleLToj7ihi//PoOcVDN2Ls=;
        h=From:Date:Subject:To:Cc:From;
        b=EmYHYFjxJeWWjuE7FpRIcMpVpbQvYa1azVujiZpRCPSsyY35BcDmkIm6LuFWO7LcC
         quQEOk/Xtic26YqcHn3Cq1abtW3zfwR/SVViwXi0dDjkOGrGdjh31hDSxgMbECUPJu
         Y0hjbsmhVLbjvw3wXRR4jroZ/0wt4KcEJtO5T98t5qWueJKOnxZP0N/73Dp3La8Kni
         CF1ajTgMlpDvjwbBXI9iQsGIgWMU3k74egfDmlG1gTirzv03lbmOxjWWn8xEiNQPrL
         7wgEpfQKHtoYHGBWJZ64zvG2edbyRtEuMFua2NLVbAJsB4I4SpwMVTJWxSXPwDqF88
         c5ZSz/hYUYN+g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id p6so561576vsj.11;
        Thu, 20 Feb 2020 22:41:25 -0800 (PST)
X-Gm-Message-State: APjAAAXmOB3023VSu11MbMsXkEZ8wfmiV131CyhJMk9kxQSkir8locVM
        BmejnN+4CwCFoIxzKFqwdYN1ZXt5JbDrqtUpLe0=
X-Google-Smtp-Source: APXvYqxlurREctTusUbI4NfwEoWK1BdgrIss1QRpDZcokNud451FRNaB4WBxWTzCUckU19r/OoH75MaXPz0bIJE05q4=
X-Received: by 2002:a67:fa4b:: with SMTP id j11mr19540806vsq.155.1582267284130;
 Thu, 20 Feb 2020 22:41:24 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Feb 2020 15:40:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASS5CCLi=7LNBHqHgdtaYgAFkcgTGYvmGds7y8cnWzBMw@mail.gmail.com>
Message-ID: <CAK7LNASS5CCLi=7LNBHqHgdtaYgAFkcgTGYvmGds7y8cnWzBMw@mail.gmail.com>
Subject: Some questions about DT-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Q1] Order of reset-names, clock-names, etc.

I have nodes that describe multiple reset lines:

It looks like this:

    reset-names = "host", "bridge";
    resets = <&rst 0>, <&rst 1>;


I looks into some existing schema files
to figure out how to describe this.

We typically do this.

reset-names:
  - items:
    - const: host
    - const: bridge


Since 'items' checks each item against the corresponding index,
it is order-sensitive.


So, the following DT passes the schema.

    reset-names = "host", "bridge";
    resets = <&rst 0>, <&rst 1>;


However, the following DT fails in the schema checking.

    reset-names = "bridge", "host";
    resets = <&rst 1>, <&rst 0>;

The latter is as correct as the former,
and should work equivalently.

If we are always required to write the "host", "bridge", in this order,
there is no point of 'reset-names'.
So, this is a restriction we should not impose.


So, if we want to accept both cases,
we need to write like this:

reset-names:
  - oneOf:
    - items:
      - const: host
      - const: bridge
    - items:
      - const: bridge
      - const: host


If we have 3 reset singles, we end up with listing 6 patterns.
Is there a good way to describe this?

Or, the policy is,
there is only one way to do one thing ?


[Q2] Tupling reg, range, etc.

In the context of dt-schema,
'reg' is essentially, array of array,
and it is important to how you tuple values.

    reg = <1 2>, <3 4>;

    reg = <1>, <2>, <3>, <4>;

    reg = <1 2 3 4>;

All of the three are compiled into the equivalent DTB,
but in the context of schema checking,
the number of items is, 2, 4, 1, respectively.

So, we need to care about tuple values correctly
based on #address-cells and #size-cells.


In some DT, I previously wrote ranges like this

   ranges = <1 0x00000000 0x42000000 0x02000000,
             5 0x00000000 0x46000000 0x01000000>;

But, now probably more correct way is:

   ranges = <1 0x00000000 0x42000000 0x02000000>,
            <5 0x00000000 0x46000000 0x01000000>;


This is a new restriction, and it also means
we cannot perform schema checking against
dis-assembled DT  (dtb->dts).

Is this correct?


-- 
Best Regards
Masahiro Yamada
