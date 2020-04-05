Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65805C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3892120675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="pVCQEfS0";
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="pVCQEfS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDEQhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:37:25 -0400
Received: from fallback21.m.smailru.net ([94.100.176.131]:38566 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDEQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:37:24 -0400
X-Greylist: delayed 3243 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2020 12:37:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ZR+qrpI2QRDJ2JEVAjghD8OlCYyG18/jk/szwztfZIE=;
        b=pVCQEfS0EYPd4o3uwAdUvDCe90E+nZG+/FKDVss5GGcF8N6/8d8lmJwJdKodE9JJoBSv3nPQvq/pCWfzoV08L+dyVl00K06p5L0606HG3vtdlNp5pDS1LflPXCltW5L46e33L9AbQHKk3Zm0gYICdGO6yQ2+9I2eUhHLNEhuGMs=;
Received: from [10.161.25.35] (port=58326 helo=smtp58.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <me@prok.pw>)
        id 1jL7Qc-0007i1-2M; Sun, 05 Apr 2020 18:43:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ZR+qrpI2QRDJ2JEVAjghD8OlCYyG18/jk/szwztfZIE=;
        b=pVCQEfS0EYPd4o3uwAdUvDCe90E+nZG+/FKDVss5GGcF8N6/8d8lmJwJdKodE9JJoBSv3nPQvq/pCWfzoV08L+dyVl00K06p5L0606HG3vtdlNp5pDS1LflPXCltW5L46e33L9AbQHKk3Zm0gYICdGO6yQ2+9I2eUhHLNEhuGMs=;
Received: by smtp58.i.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1jL7QO-0005Gl-6x; Sun, 05 Apr 2020 18:43:05 +0300
From:   Sergey Shatunov <me@prok.pw>
To:     nivedita@alum.mit.edu
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
Date:   Sun,  5 Apr 2020 22:42:46 +0700
Message-Id: <20200405154245.11972-1-me@prok.pw>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200109150218.16544-1-nivedita@alum.mit.edu>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: B8F34718100C35BD
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217365060145B739F5F5CA26B9638504F0C26F688BCB05C26794D803AF6CF205C3D7A4DA82B128B86CD4C6438D185CB39753FA6CF1DE94F8B6303
X-7FA49CB5: 0D63561A33F958A52440FFB3227236EB318160047910139AF29F9188C9FCDE298941B15DA834481FA18204E546F3947CA9FF340AA05FB58CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B292D688DDAD4E7BC389733CBF5DBD5E9B5C8C57E37DE458B4DA2F55E57A558BE7B076A6E789B0E975F5C1EE8F4F765FC6183ED2278D24C4D3AA81AA40904B5D9CF19DD082D7633A0BE77C518755DECA13AA81AA40904B5D98AA50765F790063703A99C803C4C6BCED81D268191BDAD3D209CBC2A0E48600C262FEC7FBD7D1F5BD5E8D9A59859A8B66106518975EE654D089D37D7C0E48F6C5571747095F342E857739F23D657EF2B6825BDBE14D8E7028C9DFF55498CEFB0BD9CCCA9EDD067B1EDA766A37F9254B7
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpVvaONzuzjcJuf5RTkiCWD
X-Mailru-Internal-Actual: A:0.87964429298645
X-Mailru-Sender: C70B145DBB19DC3370B3FB291950C1B54EAE3E69B558C2EAD7FAC7CAD079F9D5BA0848438379BFCE8BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDC4BB875CBFB28746199A7D5051BA5AB2AFC3153F33B0963F0F0D2DEA1FFA6D9D8
X-7FA49CB5: 0D63561A33F958A595D4E5D6CCFB01A90CBC5650B7F751A1A1B02EF0822B4C3D8941B15DA834481FA18204E546F3947CA9FF340AA05FB58CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22499FB0157AEC62EB7A76E601842F6C81A12EF20D2F80756B5F012D6517FE479FCD76E601842F6C81A127C277FBC8AE2E8B6183ED2278D24C4D3AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3DB8B71E42BA00C4F35872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqMESoaCVCpRAD/ql6jfy+t
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005C4B9C964EF46FD643F568EAB4A5C3FC499A7D5051BA5AB2A009DB4CE3002C7DB8BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes some strange things happens with my laptop.

Cold boot crashed in some early initilization logic with message 'Failed to execute /esp/.../linux.efi: Buffer Too Small'.
After couple reboots into firmware setup (bios) or hot reboot from other working kernel (without that commit) helps it to boot.
During bisecting couple times I saw different message: 'exit_efi() failed; efi_main() failed', but above tricks helps it too.
So bisect points to that commit and I tried to compile kernel with that commit reverted and it works flawlessly.

Some notes about my setup:
Kernel tree I used: Torvalds git (which recently pulls that commit).
Kernel itself with initrd and cmdline packed into systemd-boot stub (probably here can be issues too, not sure).
Secure boot enabled with custom keyring.

I can provide more info or change my setup (for example get rid of systemd-boot stub) if needed for sure.
