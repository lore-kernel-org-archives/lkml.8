Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A072EC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DCA24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWdOaI6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgB0XKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:10:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33926 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:10:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so433003plt.1;
        Thu, 27 Feb 2020 15:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tx0IPsAfgwG+TILN/HAZV3HlSTe9coOVs5pA2awyes=;
        b=cWdOaI6UdtYjvDDD78mRiRNwvqh4vFuOOlGGqiE2I6Dz3BJ20xeowNvUI2Wb2v27Yn
         jCmQ/RsSPS9CFnudpg/n87Vx0peDwnPbGM+Jl+K7UTATh2Slq3XcIrXKCp1cwyMdvcxu
         2A/9+o4vM8+eLh27IPtwmBmezC4QzHBLI3J3ccEMHbOeXHEOfamiT9WuSuw8OEqQptfS
         TPPGOuWkKH8SrWEZlDpgE2c4+T9o9os4NOtU1GEb+TpgyvvkF0cdbLZLBGaTt0fMRKdN
         LFkkwB9XlwrBhZqjKjps/Rt599MZQuKILqy/Wf3lZweoaZXVbTWOrGrU8FZhCaEz2NbB
         1AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tx0IPsAfgwG+TILN/HAZV3HlSTe9coOVs5pA2awyes=;
        b=GgjQrlIA0cOSIuMA80uVe8hB9fi6KVIYtSKFTTEPARjXqWrzPiyMn1jH1OYpHRemZL
         /2zC6bSo3Bio9cVNsU5Z04rQXce7a68+9EQq/Xl1m+d85XaUCBEjFVXHyk4NWyPrjkGr
         7/Hnr3I3I164wmk90JrGkMnzexKjOESGEnU2aBAnk7qwlqp7QX5EMx5r1tdr43nhKEI+
         7jLyBqMV0wvIlTzd7ApNUFtPCoS17f30D1vNcIRjfyCxpwfvZvtMcOrZhges0G3C2Azf
         FoaPvsbr6j/cjBHE72UVbVf8xd3+5YahcyOwq4VRZwwhCXmX7qvxSeCNz0AfOj0SxSdN
         fZDg==
X-Gm-Message-State: APjAAAVj9jrSkllj5JwdQNNdkTdFser8r5396qvM82DvtahoNb+n4Tlm
        5PiBWrFbFQdNpr3Vv0mPk9A=
X-Google-Smtp-Source: APXvYqw09IN/MZmhAU4E9H1T2aLymchy26JoyYAjLg/DFgC719gs6v2RNo0x5W+jgVkjs460YxXpuQ==
X-Received: by 2002:a17:902:7006:: with SMTP id y6mr1191261plk.84.1582845007630;
        Thu, 27 Feb 2020 15:10:07 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id u12sm7840988pgr.3.2020.02.27.15.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 15:10:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:10:00 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200227231000.GA31175@taoren-ubuntu-R90MNF91>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-8-rentao.bupt@gmail.com>
 <20200227165504.GA26955@bogus>
 <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 27, 2020 at 02:42:51PM -0800, Tao Ren wrote:
> Sorry I forgot to add you when including the dt-binding document to the
> series v4: will add you and all dt binding maintainers in v5 soon.

Just realized I already added you for the previous patch versions. Sorry
about the noise.


Cheers,

Tao
