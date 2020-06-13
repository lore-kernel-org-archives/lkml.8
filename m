Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E28C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E77207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFMGsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 02:48:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59208 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 02:48:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 389A21C0C0B; Sat, 13 Jun 2020 08:48:43 +0200 (CEST)
Date:   Sat, 13 Jun 2020 08:48:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, mhocko@suse.cz,
        linux mm <linux-mm@kvack.org>
Subject: Re: 5.7-rc0: kswapd eats cpu during a disk test?!
Message-ID: <20200613064841.GA3818@amd>
References: <20200531103431.GA28429@amd>
 <e3afe444-4541-b420-0888-575cae8aa46d@suse.cz>
 <20200612224532.GA24103@amd>
 <20200613044738.11764-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20200613044738.11764-1-hdanton@sina.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Performance of spinning rust is down, too, on x60:
> > >
> > > pavel@amd:~/misc/hw/hdd1t$ sudo ddrescue --force /dev/sda1 /dev/null
> > > GNU ddrescue 1.19
> > > Press Ctrl-C to interrupt
> > > rescued:     2147 MB,  errsize:       0 B,  current rate:    3080 kB/s
> > >    ipos:     2147 MB,   errors:       0,    average rate:    5382 kB/s
> > >       opos:     2147 MB, run time:    6.65 m,  successful read:
> > >       0 s ago
> > >       Finished
> > > pavel@amd:~/misc/hw/hdd1t$ uname -a
> > > Linux amd 5.7.0-next-20200611+ #123 SMP PREEMPT Thu Jun 11
> > >  15:41:22 CEST 2020 i686 GNU/Linux
> > >
> > > And there's something clearly wrong here:
> > >
> > >     966 root      20   0       0      0      0 R  94.4  0.0   8:18.82=
   kswapd0
> > >   23933 root      20   0    4612   1112   1028 D  80.6  0.0   0:26.40=
   ddrescue
> > > =20
> >=20
> > Same x60 under older kernel:
> >=20
> > pavel@amd:/data/fast/pavel$ sudo ddrescue --force /dev/sda4 /dev/null
> > GNU ddrescue 1.19
> > Press Ctrl-C to interrupt
> > rescued:     6593 MB,  errsize:       0 B,  current rate:   60424 kB/s
> >    ipos:     6593 MB,   errors:       0,    average rate:   95563 kB/s
> >=20
> >   3539 root      20   0    4616   1136   1048 D  21.4  0.0   0:15.63 dd=
rescue
> >    865 root      20   0       0      0      0 S   6.9  0.0   0:04.91  k=
swapd0
> >=20
> > Linux amd 4.6.0+ #172 SMP Sun Aug 14 11:25:34 CEST 2016 i686 GNU/Linux
> >=20
> > These are more reasonable numbers.
>=20
> Treat referenced & active pages as reclaim cost.

That helps a bit, but we are still nowehere near v4.6 performance:

pavel@amd:/data/fast/pavel$ sudo ddrescue --force /dev/sda2 /dev/null
GNU ddrescue 1.19
Press Ctrl-C to interrupt
rescued:     8559 MB,  errsize:       0 B,  current rate:   53084 kB/s
   ipos:     8559 MB,   errors:       0,    average rate:   71327 kB/s

 3933 root      20   0    4612   1216   1128 R  68.6  0.0   0:12.14  ddresc=
ue
   967 root      20   0       0      0      0 R  64.4  0.0   1:18.67  kswap=
d0
=20
(I applied the patch on 5.7.0-next-20200611+).

Do we know which original change is causing this? Any other ideas?

Thanks,
									Pavel

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2020,6 +2020,7 @@ static void shrink_active_list(unsigned
>  	struct page *page;
>  	unsigned nr_deactivate, nr_activate;
>  	unsigned nr_rotated =3D 0;
> +	unsigned nr_refered =3D 0;
>  	int file =3D is_file_lru(lru);
>  	struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> =20
> @@ -2070,7 +2071,8 @@ static void shrink_active_list(unsigned
>  				nr_rotated +=3D hpage_nr_pages(page);
>  				list_add(&page->lru, &l_active);
>  				continue;
> -			}
> +			} else if (!file)
> +				nr_refered++;
>  		}
> =20
>  		ClearPageActive(page);	/* we are de-activating */
> @@ -2098,6 +2100,14 @@ static void shrink_active_list(unsigned
>  	free_unref_page_list(&l_active);
>  	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
>  			nr_deactivate, nr_rotated, sc->priority, file);
> +	if (file)
> +		sc->file_cost +=3D nr_rotated;
> +	else
> +		/*
> +		 * add cost to avoid swapin in the near future which incurs IO
> +		 * on top of reclaim
> +		 */
> +		sc->anon_cost +=3D nr_refered;
>  }
> =20
>  unsigned long reclaim_pages(struct list_head *page_list)
> @@ -2311,11 +2321,13 @@ static void get_scan_count(struct lruvec
>  	file_cost =3D total_cost + sc->file_cost;
>  	total_cost =3D anon_cost + file_cost;
> =20
> -	ap =3D swappiness * (total_cost + 1);
> -	ap /=3D anon_cost + 1;
> -
> -	fp =3D (200 - swappiness) * (total_cost + 1);
> -	fp /=3D file_cost + 1;
> +	ap =3D swappiness * total_cost;
> +	if (anon_cost)
> +		ap /=3D anon_cost;
> +
> +	fp =3D (200 - swappiness) * total_cost;
> +	if (file_cost)
> +		fp /=3D file_cost;
> =20
>  	fraction[0] =3D ap;
>  	fraction[1] =3D fp;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7kdskACgkQMOfwapXb+vJLZgCgr2WMQakHi4TeSFcM6DVT83aS
daYAn1iKN+iF7Z0GWhcPUHseZYmT+x7A
=yJgG
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
