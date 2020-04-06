Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C9C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A97B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="rBOEklnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFTvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:51:35 -0400
Received: from sonic305-20.consmr.mail.gq1.yahoo.com ([98.137.64.83]:43937
        "EHLO sonic305-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDFTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1586202691; bh=AAubdb+tNTjPwoyqCH1GA4q2yTejWcK2E7tiZaIw2gM=; h=Date:From:Subject:To:Cc:References:From:Subject; b=rBOEklnQwk6BbVKJ8OnZvewaYukWWNVxzB9UCG9OYxKitP/ELpZQXN5FGjzHFb8y7sMS29jZZwvoIZa3iYpGxFWEJjLl7FdmYdHeyUBYDwVfHXdgu/vv0Yj8FmXKPgM6PI3+W9V3/Gb/0n88zyIzNT94WgOn3vnySG5lTDC7Mlg1Nam1eVX3Xqlm2oOqXOQH0EXshvqTib4CUX1Zr9bD5CGKwr3iiVkJ2sZp3sJP4NM0U5EEBetp7iOj8jPhFk0Tb4b//JXRtd8vTFCzO+1cZTqYuc8yhb20bUXv/YdOew0TJ3ikouV/D1Kp0IFx45OQWE0+r7sAGufenOdygrYYkw==
X-YMail-OSG: sqDwaY0VM1lQsyhhQWTp1ASOAFZhscuAOZaJTjX1KabUoX45MRikl3Yl1DXC85t
 nDX0uI00pziii9pvBCitQo69UOVYYTBu4VTXmEQ2NzFe6SQGn.qLuXzdPCY2n8VMkIY2XMLGNg1O
 zQtGi14sSHGWzLdz5z5X9.yB5.0jrT0SKc9DOLepsaz3fG3XbEe4Tp7FAiuS8o4BcOMZVCve7W5r
 er5Cy5F6RBRSB8.0Vff2uKWpId4zLRu7z8FxBQL8K3jBk3udox.GJFYjJm4Eyu.8ZVDntAx2hGyf
 ojNiIPJVrDKXHb_XTXKVNrqVPIo2pG.9XryxJzIFfPei8pO4OKgQke8Lbe5rHN2XUGDSq6hcIcug
 zwSSYrvJ1GIxZYBruXVffZxqgo8c9LAyk1rTHtS.IBSENUXlOjiktgSNODSCuHtI_IvG9XaBj8MH
 _f9fPW2jTtqdnZOvtbS3mqvKDWHUsY_vhxTCDFcuLRRenTS3HJqGUPAvllbL3CQFedvjeEzYd1ea
 50EBh8CU5Ookn6bC7S5E3juHEKHMLH52Tp0NY9z.BBOF3aVJOUcJwshVVc_7wZuSdCowxrVX_diw
 dmu4C8jFFx3BivLQo9EcgN4usIjHidufs9uyH1bqKD_8nNQCD9uAxH.KUJnH6c1N4EC7PW7BmplH
 i_tBfCUfmwz8P9KzhJh0FHCjIknUUovsBePLwdChUrYk2rcMinOQlvqykfVuyHTRvB5d._6HX4Sk
 r2fKUJAVsFo1svmdinTSoEOEsbdjnVrEi4s067zsrvb4kt5LHLxzl_DSFLyOjvVdu4gKwRN3odP8
 X2zj_e6KWcurMnlO21FkbnsFDLEF4RIkz1vseMSvhqT7DIze1bH9q3IDLf.9CrQD7GMdyAEAXuAs
 Uuam_X6XRbAGZmniSri251fNyl_PdS5NsUsOLX3E4XII6GPlPijzB.Q0fRzfi85qwj39LgvofgZu
 rbNR0upAqMtA7TzN0I0W.M7iFJBydd9hwxETEGPo6IBc6wIskr7uj3XLD1d2VZ4QFSR7Y9xPBp6r
 D2QCrqNfMzzMdF48FAeaaWNWLJfchzhcPxYDpdCypOIl.cS_87WRP6lzoOH6aaSirVFzd5ENwjnQ
 TyeE5jIQb7KWEsvn0J0btX96bJJxBY2QxnaxGeHul1jvgNx_brWYlwiaH0klFZi5._C9.1lNB7zv
 OZ.8MSCmq9jmJnecYmVb9Kvk5LQFdVQqtwg2J8ihjEcGCRYeGwsZkknp4btZr11RWTRXWt.By3tN
 4rNSa8Xxf4WxbcAq9ydIKfENLk7T9rBy4zp7v2kOktFa177mwKWpx7GTQZlelRZEAJbBQx4lgBMB
 uqgcwMl1w4UBl05xopnzmkX1GgvnQKE814PcPc92BhG529SB67KveMIWSodzVpqfocbveZR8vg6s
 Ja4.6x5tFEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 6 Apr 2020 19:51:31 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a13dce9f8757db0d103665696d9f0;
          Mon, 06 Apr 2020 19:51:26 +0000 (UTC)
Date:   Mon, 06 Apr 2020 15:51:22 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Bad rss-counter state from drm/ttm, drm/vmwgfx: Support huge TTM
 pagefaults
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, thomas_os@shipmail.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?b?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
MIME-Version: 1.0
Message-Id: <1586138158.v5u7myprlp.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1586138158.v5u7myprlp.none.ref@localhost>
X-Mailer: WebService/1.1.15620 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 314b658 with amdgpu, starting sway and firefox causes "BUG: Bad=20
rss-counter state" and "BUG: non-zero pgtables_bytes on freeing mm" to=20
start filling dmesg, and then closing programs causes more BUGs and=20
hangs, and then everything grinds to a halt (can't start more programs,=20
can't even reboot through systemd).

Using master and reverting that branch up to that point fixes the=20
problem.

I'm using a Ryzen 1600 and AMD Radeon RX 480 on an ASRock B450 Pro4=20
board with IOMMU enabled.
