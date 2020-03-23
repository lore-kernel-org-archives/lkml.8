Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4302C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DED20771
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="E0yd7jBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCWOza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:55:30 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:5282 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCWOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1584975329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lBVVrBypVz+RADchWAvVwdaNJBZHScOt3Cc1rORYDdI=;
  b=E0yd7jBHfDprI9Yvwf14vyp1Ld6j2+CWTLhYs55yqRAqN6edcTI0x+1o
   YnrfqpnOrBZk/qndUXjkGjsRTsgiMBehih2o/jiuHwV3bVJdSDi2omk4Z
   NTt6r9mB8f05jApUSY2oHOCKc5gM4RO1ZR375j00y8nMgRz7TwC4rD9ym
   Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: LufU9WBY251XB+4L29AisBql4KftCAViZA91z6ekHJUun8XztQ5VLTDD6QOQnumWlhlQQz5qdh
 ViLl+cJqzd00AKgXop8Fsz4Aq4zi+Bp/B7SYLbiis8nhA5xVtMm0ZqnujSruIK+Dy5xuBNLC/2
 5UO4lElqyMQ7hHRML/AfC0itKUN+pMSRqvaUGUxkbaXkrY7w4cNHTogb45wa8eH6PMLzzMYnrK
 uyoQrBnn/NJnP4y2udfj7H2Ly+gjzE7D6R1l+AzcNd+uyWyMsR0JqHUUH1MVlmmiTiS4K4J0YY
 7bk=
X-SBRS: 2.7
X-MesageID: 15118429
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,296,1580792400"; 
   d="scan'208";a="15118429"
Date:   Mon, 23 Mar 2020 15:55:22 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xen-pciback: fix INTERRUPT_TYPE_* defines
Message-ID: <20200323145522.GC24458@Air-de-Roger.citrite.net>
References: <20200320030929.24735-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320030929.24735-1-marmarek@invisiblethingslab.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 04:09:18AM +0100, Marek Marczykowski-Górecki wrote:
> xen_pcibk_get_interrupt_type() assumes INTERRUPT_TYPE_NONE being 0
> (initialize ret to 0 and return as INTERRUPT_TYPE_NONE).
> Fix the definition to make INTERRUPT_TYPE_NONE really 0, and also shift
> other values to not leave holes.
> But also, do not assume INTERRUPT_TYPE_NONE being 0 anymore to avoid
> similar confusions in the future.
> 
> Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable flag writes")
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
