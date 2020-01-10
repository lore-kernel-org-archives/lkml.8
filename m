Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3391AC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD1B20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axm+SZ6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgAJJwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:52:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29109 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727281AbgAJJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578649958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9OBjJjtAJRIezJx3Zj+ASC4bWFGhwZpN4WumVttPls=;
        b=axm+SZ6M2yq7J2jU5yUskgCGaNQzEZA3mLPsMT2e5TrJo3ST8S62JTd1FBJ4k2UOx5Sj5L
        Fka4DC5ssLN8Eoof5C6CLkiCA671qCcds4L/ohVzfez09xy4Qu10nD2sAAy6KRt6WgnIcY
        wq8UID76pbpvNg/njmYwFWOVzyR4C0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-Y6hD424wN-WIart8DjvMnA-1; Fri, 10 Jan 2020 04:52:24 -0500
X-MC-Unique: Y6hD424wN-WIart8DjvMnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0987801E7A;
        Fri, 10 Jan 2020 09:52:22 +0000 (UTC)
Received: from localhost (ovpn-116-201.ams2.redhat.com [10.36.116.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D42F7D979;
        Fri, 10 Jan 2020 09:52:18 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:52:17 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
Message-ID: <20200110095217.GB573283@stefanha-x1.localdomain>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
 <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 01:13:09PM +0800, Liu, Jing2 wrote:
>=20
> On 1/7/2020 12:18 AM, Stefan Hajnoczi wrote:
> > On Fri, Dec 20, 2019 at 11:25:03PM +0800, Jing Liu wrote:
> > > Upgrade virtio-mmio to version 3, with the abilities to support
> > > MSI interrupt and notification features.
> > >=20
> > > The details of version 2 will be appended as part of legacy interface
> > > in next patch.
> > Cool, MSI is useful.  Not a full review, but some comments below...
>=20
> Hi Stefan,
>=20
> Thanks for reviewing patches! Glad to see that MSI is welcome.
>=20
> > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > ---
> > >   content.tex  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++=
-----------
> > >   msi-status.c |   5 ++
> > >   2 files changed, 163 insertions(+), 33 deletions(-)
> > >   create mode 100644 msi-status.c
> > >=20
> > > diff --git a/content.tex b/content.tex
> > > index d68cfaf..eaaffec 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -1597,9 +1597,9 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi
> > >     }
> > >     \hline
> > >     \mmioreg{Version}{Device version number}{0x004}{R}{%
> > > -    0x2.
> > > +    0x3.
> > >       \begin{note}
> > > -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virt=
io Over MMIO / Legacy interface}) used 0x1.
> > > +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virt=
io Over MMIO / Legacy interface}) used 0x1 or 0x2.
> > "Legacy devices" refers to pre-VIRTIO 1.0 devices.  0x2 is VIRTIO 1.0
> > and therefore not "Legacy".  I suggest the following wording:
> >=20
> >        Legacy devices (see \ref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}) used 0x1.
> > +     VIRTIO 1.0 and 1.1 used 0x2.
> Thanks for the guide.
> > Did you consider using a transport feature bit instead of changing the
> > device version number?  Feature bits allow more graceful compatibility:
> > old drivers will continue to work with new devices and new drivers will
> > continue to work with old devices.
>=20
> Yes, we considered using a feature bit from 24~37 or above, while a conce=
rn
> is that,
>=20
> the device which uses such bit only represents the behavior of mmio
> transport layer but not common behavior
>=20
> of virtio device. Or am I missing some "transport" feature bit range?

https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x=
1-4100006

Feature bit 39 is reserved and can be used.

This is similar to when the SR_IOV (37) feature bit was added for
virtio-pci.

> > >       \end{note}
> > >     }
> > >     \hline
> > > @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\labe=
l{sec:Virtio Transport Options / Vi
> > >       accesses apply to the queue selected by writing to \field{Queue=
Sel}.
> > >     }
> > >     \hline
> > > -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> > > -    Writing a value to this register notifies the device that
> > > -    there are new buffers to process in a queue.
> > > +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
> > > +    Reading from the register returns the virtqueue notification con=
figuration.
> > > -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > > -    the value written is the queue index.
> > > +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-=
specific Initialization And Device Operation / Notification Address}
> > > +    for the configuration format.
> > > -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > -    the \field{Notification data} value has the following format:
> > > +    Writing when the notification address calculated by the notifica=
tion configuration
> > > +    is just located at this register.
> > I don't understand this sentence.  What happens when the driver writes
> > to this register?
>=20
> We're trying to define the notification mechanism that, driver MUST read
> 0x50 to get the notification configuration
>=20
> and calculate the notify address. The writing case here is that, the noti=
fy
> address is just located here e.g. notify_base=3D0x50, notify_mul=3D0.

I still don't understand what this means.  It's just an English issue
and it will become clear if you can rephrase what you're saying.

> > > -    \lstinputlisting{notifications-le.c}
> > > -
> > > -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Vir=
tqueues / Driver notifications}
> > > -    for the definition of the components.
> > > +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-=
specific Initialization And Device Operation / Available Buffer Notificatio=
ns}
> > > +    to see the notification data format.
> > >     }
> > >     \hline
> > >     \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> > >       Reading from this register returns a bit mask of events that
> > > -    caused the device interrupt to be asserted.
> > > +    caused the device interrupt to be asserted. This is only used
> > > +    when MSI is not enabled.
> > >       The following events are possible:
> > >       \begin{description}
> > >         \item[Used Buffer Notification] - bit 0 - the interrupt was a=
sserted
> > > @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi
> > >     \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
> > >       Writing a value with bits set as defined in \field{InterruptSta=
tus}
> > >       to this register notifies the device that events causing
> > > -    the interrupt have been handled.
> > > +    the interrupt have been handled. This is only used when MSI is n=
ot enabled.
> > >     }
> > >     \hline
> > >     \mmioreg{Status}{Device status}{0x070}{RW}{%
> > > @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label=
{sec:Virtio Transport Options / Vi
> > >       \field{SHMSel} is unused) results in a base address of
> > >       0xffffffffffffffff.
> > >     }
> > > +  \hline
> > > +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
> > > +    Reading from this register returns the global MSI enable/disable=
 status and maximum
> > > +    number of virtqueues that device supports.
> > > +    \lstinputlisting{msi-status.c}
> > > +  }
> > Why is it necessary to combine the number of virtqueues and global
> > MSI enable/disable into a single 16-bit field?
>=20
> Originally, we want this 16-bit Read-Only, so we put some RO things toget=
her
> and separate
>=20
> enable setting command to next register.
>=20
> > virtio-mmio uses 32-bit registers.  It doesn't try hard to save registe=
r
> > space so it's strange to do it here (11-bit number of virtqueue field
> > but 32-bit QueueSel field).
>=20
> In order to improve performance/save register space,=A0 we combine some d=
ata
> together.
>=20
> For example, combine MSI cmd operator (e.g. enable/disable, vector setup)
> with argument (e.g. 1/0,=A0 queue index).
>=20
> But it seems we miss the consistency with QueueSel.=A0 So do you think if=
 the
> max queue number should be 32-bit,
>=20
> which means it must be the same with QueueSel? If so, I guess we need som=
e
> re-organization. :)

I suggest following the 32-bit register size convention unless there is
a specific reason why using other register sizes is absolutely necessary.

> >=20
> > > +  \hline
> > > +  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
> > > +    The driver writes to this register with appropriate operators an=
d arguments to
> > > +    execute MSI command to device.
> > > +    Operators supported is setting global MSI enable/disable status
> > > +    and updating MSI configuration to device.
> > If the global MSI enable/disable state is written in this register,
> > consider making this register readable too so the global MSI
> > enable/disable state can be read from it.
>=20
> Read enable/disable state is in 0x0c0.

The read-only 0xc0 register combines two pieces of information:
1. Global MSI enable/disable state
2. Number of virtqueues (or is "number of MSI vectors" a more accurate
   term?)

A simpler way of organizing the registers is:
MsiMaxVectors R
MsiState RW

This is simpler because drivers can read the MsiMaxVectors field and
treat the value as an integer (no masking required).  And a person
reading the specification instantly knows how to fetch the MSI
enable/disable state when they read the MsiState register description.
They don't need to look through all the other registers to find the one
that allows them to read the state.

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4YSVEACgkQnKSrs4Gr
c8ibRgf+LwtNAlgM9K18CstvDCtydI06SsjgNsTo8QdHEER0Jr0777rde+RCf3I8
niTrs7LYiU2f/6RK5jYJNLdDujfjU3bnJhj9paJnCmgPFRvlgRjoQ7lmbui+XroL
vkLf3M0oBV19VzoceqymfhZpNBsbJZqsOd9+XP9P6LiCukWDTo+eGmhUUjUX1UTH
W1gARScMLXmkJjbLE55dFksLS20+r9c78hbiY/EO1ecU6A0i84rtOB0VHBcMv7zi
53gHBDXzWECJZsp6AJJA7/Vb2j9OBOJpY2ELQDwx7Fz5wQ6/cN4QJM4m62zY/HXm
NwtIAPOhSAPeNp0AZXhqV4LJI6ZMYA==
=umeK
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

