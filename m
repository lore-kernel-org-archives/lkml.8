Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F08020728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAQRNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:13:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:37418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:13:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C422B2A7;
        Fri, 17 Jan 2020 17:13:35 +0000 (UTC)
Date:   Fri, 17 Jan 2020 18:13:31 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200117171331.GA17179@blackbody.suse.cz>
References: <20191127174317.GD26807@dhcp22.suse.cz>
 <20191204132812.GF25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041524290.18825@www.lameter.com>
 <20191204153225.GM25242@dhcp22.suse.cz>
 <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
 <20200109145236.GS4951@dhcp22.suse.cz>
 <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Jan 09, 2020 at 11:44:15AM -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> I looked at it - there wasn't really any compelling followup.
FTR, I noticed udevd consuming non-negligible CPU cycles when doing some
cgroup stress testing. And even extrapolating to less artificial
situations, the udev events seem to cause useless tickling of udevd.

I used the simple script below
cat measure.sh <<EOD
sample() {
        local n=$(echo|awk "END {print int(40/$1)}")

        for i in $(seq $n) ; do
                mkdir /sys/fs/cgroup/memory/grp1 ;
                echo 0 >/sys/fs/cgroup/memory/grp1/cgroup.procs ;
                /usr/bin/sleep $1 ;
                echo 0 >/sys/fs/cgroup/memory/cgroup.procs ;
                rmdir /sys/fs/cgroup/memory/grp1 ;
        done
}

for d in 0.004 0.008 0.016 0.032 0.064 0.128 0.256 0.5 1 ; do
        echo 0 >/sys/fs/cgroup/cpuacct/system.slice/systemd-udevd.service/cpuacct.usage
        time sample $d 2>&1 | grep real
        echo -n "udev "
        cat /sys/fs/cgroup/cpuacct/system.slice/systemd-udevd.service/cpuacct.usage
done
EOD

and I drew the following ballpark conclusion:
1.7% CPU time at 1 event/s -> 60 event/s 100% cpu

(The event is one mkdir/migrate/rmdir sequence. Numbers are from dummy
test VM, so take with a grain of salt.)


> If this change should be pursued then can we please have a formal
> resend?
Who's supposed to do that?

Regards,
Michal


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4h6zYACgkQia1+riC5
qSgKoA//ZHOaTtyAwAzIU0cfBkSxBLjGxpA8TqqGk7nRIhCI9CK9bQuIifOOfWQV
YYL3ApPANU6o+bYOxM8xXe4G2TXZBF/Q23jjORGv7C2bRwldTNvYZ0dvYwq0bQ3n
l0pXy1R8IDxSB3CPgUE6b7taBjrIuMds63i7MhwZ3CxW540cUGm8mPpB9RE5kinh
IGduSTM73kbVypVHuw1hMhZu0QueepUAawpZIFK6wbOsade0NE0p6Pq0xxVCRp+B
cYq9O161YcED0HIR+fdC8q63VN8tHJJovKJbVocrzweEonSmPdoBap32guhlMFTQ
rPs3tD6MV0SIOfqTN4A6b7IHrxqiWYs4aqktiCt1iQj2WDKwVIVDweA73vyehQXa
wXZE+mak1gNjxwKAWAtsMLZl7TupqPrwbZIUq2vNb/ob+zQ+wKfxHfq0BMRMG/v5
/QPzbZalrzfOZvtjgMrZXHY6eNfHUm7PkJWEHlY3WshN7Crb1tp0+UOi6DyexXsc
Y0V3JAP3gUh2Y+hTZVQwmutNt7zDLSqo0F14SRN3bNhVL/3Hy59e6tIqVktJHq8b
ZMwnpvclnBWdcLzoH5hq7PsAnNJDhdRRAFsN3xFfIjmIFEIN07fXTxWSrpasYohC
g7eC1qGJf2vSWdvpj8kVLiaPRX6wYK0sUg4duwQbyg7Y26RG0JU=
=VSEp
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
