Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE7FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E136820409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bvbIOljw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCZRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:21:12 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:44023 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:21:11 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 13:21:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585243271;
  h=from:mime-version:content-transfer-encoding:message-id:
   date:to:cc:subject:in-reply-to:references;
  bh=cmRchjwNto76J2Gl/1QYJEwtQJh32wTy2r7u8WH1uLE=;
  b=bvbIOljwzygxqJ9m9feKhKYdZIk1n7dSloBLbdDEYKTZAnq6pDIm4bMG
   WvPV5uxyKHfWbhudXuoBE7Nvpg9zz13tMgMPTu1tEXlOhQtZbU0iEzI+W
   HXEomzFCQavs7czLvvxEb5KB1K2rZgX4JLUgjCfHcxdesXWYE2mFqb5PW
   o=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=ian.jackson@citrix.com; spf=Pass smtp.mailfrom=Ian.Jackson@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  ian.jackson@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Ian.Jackson@citrix.com";
  x-sender="ian.jackson@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  Ian.Jackson@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Ian.Jackson@citrix.com";
  x-sender="Ian.Jackson@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Ian.Jackson@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 1Q0rUJbKc0Aoxy3/YvCB1Nq30ZyL1lCn/Ogum4ql1ohORUmPJS6t66tqmdmxlTyTrJVED56ncv
 RSa6FYsjxrBAKDGf5gCSVx+EoVnF8/TtxuMKMhyK7SO91z2Po8g+iNKPGnxf2veWb0T2UyvJKZ
 GIcUZWyTT95kmTDt6XAtj8ggVxEi81jxfQvZ54sKLinF+r5rrSj+lajTHFUcld+u8cmPogmVh/
 O3zUBvCWanxWmgMwVaRFncFFFhm/1/ZxXNvv3ogA0YFdoH+26CZ+fw7aOiqRGv5MVcY6/LKSUQ
 afE=
X-SBRS: 2.7
X-MesageID: 14913055
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,309,1580792400"; 
   d="scan'208";a="14913055"
From:   Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <24188.58071.444694.257081@mariner.uk.xensource.com>
Date:   Thu, 26 Mar 2020 17:13:59 +0000
To:     Roger Pau Monne <roger.pau@citrix.com>
CC:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/2] xen: enable BALLOON_MEMORY_HOTPLUG by default
In-Reply-To: <20200324151628.GM24458@Air-de-Roger.citrite.net>
References: <20200324150015.50496-1-roger.pau@citrix.com>
        <20200324150015.50496-2-roger.pau@citrix.com>
        <f4ce1d95-c80a-8727-7ddc-9199bb2036c4@suse.com>
        <20200324151628.GM24458@Air-de-Roger.citrite.net>
X-Mailer: VM 8.2.0b under 24.5.1 (i686-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Pau Monne writes ("Re: [PATCH 2/2] xen: enable BALLOON_MEMORY_HOTPLUG by default"):
> I would rather have it always on if possible, as gntdev or privcmd
> (when used to map foreign pages from user-space) will also require it,
> and they are not gated on XEN_BACKEND AFAICT.

Currently there seem to be problems with this:

http://logs.test-lab.xenproject.org/osstest/logs/149014/test-amd64-amd64-dom0pvh-xl-intel/info.html

For now I have rolled back the change in osstest to enable this option
explicitly.

Ian.
