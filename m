Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFFC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D642074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="blxVZnnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgCZQoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:44:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:55117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZQoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585241001;
        bh=UVbrUb+k2mZ8gQQp531jOp6OyS4N5ogYYHX6KJL1YCU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=blxVZnnmMDa/b8P3caKBpshrtPnRziu3jzDhlTkuXpnrj+kNY0/4RZzksYDbh7hnw
         fLII8RoVZM59hxxC7Aj7CGOJQjjSYqWOqBatgQZzUauZKcb5LVFJH3ZIsIPtRRWNqP
         PBfb3GxDKCKxu36ivhmfFT6LVVOW/g3jq67uacfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wpt-1jOCXY1wrp-012Jls; Thu, 26
 Mar 2020 17:43:21 +0100
Date:   Thu, 26 Mar 2020 17:43:05 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro instead of hex value
Message-ID: <20200326164304.GA3629@ubuntu>
References: <20200320171056.7841-1-oscar.carter@gmx.com>
 <20200323073518.GK4650@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323073518.GK4650@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ISIX9ycQftVxIKBz3LnMcYJeXp51Z1jCaxo7XqwvIjHSJSTg4nM
 JHlz+vlVy60PwwLMtbHqQ73yjNPQcFb0B6WkzOj35hsEKcFQ/TGpipUFZFZI4kcjBBgamOm
 W6yGr/ypA+RtBgjIHDOsjMXSIy4D/Ldb9ZY6wYMLUdbkpbnNbtgs+YRD5ZaxiU4KIcftjfo
 zlA5IuYuFS7vx2G/IOXeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EXGQy6V7unU=:tkPDTF0Nvd+ujPunjlx3+r
 ONWMxR290GHbd7nj23A7c0sE5BxHQ2u0WEpXVey+UeIvPpfUVX671q+MFYlQB+Xh/VlJIOTMA
 GFI8OoPh1l4jL2+AqaOI3REcvrpKcGMNgRmNjGT9AkzDKEYabzMZIyqBmpMFtPEZZnL3wbJJ1
 uYIItOH8DcyUNX1rrOCO1soO5V8tUNJVtgfrXtUrIwt7PKkyuooaKcV7T93sM5XWB+4QGTJPA
 km8FuHEJJbEegto2Jtuw80yltvM2YYCewUlXeU0CJH2onnJb4PW03zoihfYQ9ASqDb2QBw9tj
 R0ALfO+fl6WM5eaiCO5sLXjUCNEor12FR5A29b1yfn94qJwj7GvU+E3bED9brSQ2q0shHetVj
 ZvIGLTv/bc5nwGTCBpE6pKRyWu4pde6j9ZafRryg1BgrhXNF6MmyRn/m42aGJvOuUZBJDsn5T
 qRTMPWi0CsHQrgoZswd0Of2XitvMlpoBUQnI5dPclaOzk+Xsz8yfH9mn9Ut6i2dGTFPnwq3bE
 lIG/KakrujCm5ylI9EVXcGmKu7aBH9d+8Fnmp4GVDUVM7eGORYBZ40/Q/O5+Ls5k3by7QoMVQ
 JSi4VnbaY6L1qE9sqdEIjUdCH6CHnNjJ4cgEX4POSSPhqKIJvucAeI6h04hVQwnHf0QgdQtfb
 WepzEcAPBGGGwckl/ezimRNP6UrwWpKJlvkB9Ldddeyd3ixbl0F2lSB/H+gTLb/qu2vJipc0Z
 dY5V9kcHmkOqUA3/aaaoyWc/pxkpQfChGEb1tbIvL++QjpWq6oWYOe7ldc4WsK6l4pgcYsyFR
 2/1Ogtb+NJP6nFsL6temHUyoZNq6OzQtRl8PTKK/bH+ki8v1Zq99IimJiGOOgx21/wSeZxEEL
 8unoondSozi5sjqrU6Ex3kR4ww9Cw5HIR/LyrpilYdLcg66K5xjxZUEVDFef+55Cd8ZtSmHI7
 YDamsQdrCNRX/vLwh8FCuHOzvyumN63Ql2SHvhGuhR/Rq1PKld8mMV/mv+XZxKGw5dyJYRILg
 jtQts1oz132BK8mFwjvHnJINdwxHCEH688kgSGo9JE0pXUJ6l4CrH3EY99yjJ28O0nMdRtE0D
 FxQPtzr5aHVnaWNO/JEW1+l+a5kqlzvSEi4GQ6UywDsjCXGaZ19HgRkAQQUQqE1g5C1tiswy5
 wAgOQcOGgdIFEBB/2YLq+MxGvz+WJQE/mkQ4PvAhRWt6S5/bdb71kvkljU6QM+FM6ivIS1di3
 D+4e4Eegi7Eolq97Y
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 10:35:18AM +0300, Dan Carpenter wrote:
> On Fri, Mar 20, 2020 at 06:10:56PM +0100, Oscar Carter wrote:
> > -#define RSR_ADDRBROAD       0x80
> > -#define RSR_ADDRMULTI       0x40
> > +#define RSR_ADDRBROAD       BIT(7)
> > +#define RSR_ADDRMULTI       BIT(6)
> >  #define RSR_ADDRUNI         0x00
> > -#define RSR_IVLDTYP         0x20        /* invalid packet type */
> > -#define RSR_IVLDLEN         0x10        /* invalid len (> 2312 byte) =
*/
> > -#define RSR_BSSIDOK         0x08
> > -#define RSR_CRCOK           0x04
> > -#define RSR_BCNSSIDOK       0x02
> > -#define RSR_ADDROK          0x01
> > +#define RSR_IVLDTYP         BIT(5)	/* invalid packet type */
> > +#define RSR_IVLDLEN         BIT(4)	/* invalid len (> 2312 byte) */
> > +#define RSR_BSSIDOK         BIT(3)
> > +#define RSR_CRCOK           BIT(2)
> > +#define RSR_BCNSSIDOK       BIT(1)
> > +#define RSR_ADDROK          BIT(0)
>
> I like these ones because I do think the new version is more clear
> now.
>
> >  /* Bits in the EnhanceCFG_0 register */
> >  #define EnCFG_BBType_a		0x00
> > -#define EnCFG_BBType_b		0x01
> > -#define EnCFG_BBType_g		0x02
> > -#define EnCFG_BBType_MASK	0x03
> > -#define EnCFG_ProtectMd		0x20
> > +#define EnCFG_BBType_b		BIT(0)
> > +#define EnCFG_BBType_g		BIT(1)
> > +#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
> > +#define EnCFG_ProtectMd		BIT(5)
>
> Probably EnCFG_BBType_MASK should be defined using the other defines.
>
> #define EnCFG_BBType_MASK (EnCFG_BBType_b | EnCFG_BBType_g)
>
> Otherwise it looks good.  Can you change that one thing and then add
> my Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
Ok, i will make this change and i will send and incremental patch with the
"Fixes:" tag due to the this patch has already been added to the staging-n=
ext
branch of the greg staging tree.

> regards,
> dan carpenter
>
thanks,

oscar carter
